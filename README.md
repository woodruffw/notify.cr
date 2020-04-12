notify.cr
=========

[![Build Status](https://img.shields.io/github/workflow/status/woodruffw/notify.cr/CI/master)](https://github.com/woodruffw/notify.cr/actions?query=workflow%3ACI)

A Crystal library for
[Desktop Notifications](http://www.galago-project.org/specs/notification/0.9/index.html) compatible
notification daemons. Uses DBus internally.

**Important**: Platforms with notification systems that don't use DBus/Desktop Notifications are
currently **not supported**. If you'd like support for one of these platforms (e.g., macOS and
Windows), please contribute one!

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  notify:
    github: woodruffw/notify.cr
```

## Usage

```crystal
require "notify"

notifier = Notify.new

notifier.notify "hello", body: "<b>world!</b>"
```

## Contributing

1. Fork it (<https://github.com/woodruffw/notify/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [woodruffw](https://github.com/woodruffw) William Woodruff - creator, maintainer
