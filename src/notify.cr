require "dbus"

require "./notify/*"

# `Notify` is a Crystal library for
# [Desktop Notifications](http://www.galago-project.org/specs/notification/0.9/index.html)
# compatible notification systems. It uses DBus internally to connect to the user's notification
# daemon.
class Notify
  private getter iface : DBus::Interface

  # An array of strings indicating the capabilities of this notification daemon.
  getter capabilities : Array(String)

  # An array of strings indicating the version and vendor of this notification daemon.
  getter information : Array(String)

  # Creates a new instance of `Notify`.
  def initialize
    bus = DBus::Bus.new
    obj = bus.object("org.freedesktop.Notifications", "/org/freedesktop/Notifications")
    @iface = obj.interface("org.freedesktop.Notifications")
    @capabilities = @iface.call("GetCapabilities").reply
      .first.as(Array(DBus::Type)).map(&.as(String))
    @information = @iface.call("GetServerInformation").reply
      .as(Array(DBus::Type)).map(&.as(String))
  end

  # Checks whether the user's notification daemon supports *feature*.
  #
  # The list of currently standardized features can be found here:
  # <http://www.galago-project.org/specs/notification/0.9/x408.html#command-get-capabilities>
  #
  # ```
  # n.capability?("body") # => true
  # ```
  def capability?(feature : String)
    capabilities.includes? feature
  end

  # Creates a new notification. *summary* is the only required parameter.
  #
  # See <http://www.galago-project.org/specs/notification/0.9/x408.html#command-notify> for
  # information on optional parameters.
  #
  # Returns a notification ID that can be used with `close` or as *replaces_id* in
  # subsequent calls to `notify`.
  #
  # ```
  # n.notify "hello", body: "<b>world!</b>" # => 1337
  # ```
  def notify(summary, app_name = "", replaces_id = 0u32, app_icon = "", body = "",
             actions = [] of String, hints = {} of String => DBus::Variant, expire_timeout = -1)
    params = [app_name, replaces_id, app_icon, summary, body,
              actions, hints, expire_timeout]

    iface.call("Notify", params).reply.first.as(UInt32)
  end

  # Closes the open notification whose identifier is *id*, or does nothing if that notification
  # is already closed.
  #
  # ```
  # n.close(1337)
  # ```
  def close(id : UInt32)
    iface.call("CloseNotification", [id]).reply
  end
end
