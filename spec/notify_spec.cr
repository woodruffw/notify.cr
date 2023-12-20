require "./spec_helper"

describe Notify do
  it "should send a notification" do
    notifier = Notify.new
    notifier.notify "hello", body: "<b>world!</b>"
  end
end
