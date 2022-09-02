# MissionControl::Web
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "mission_control-web"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install mission_control-web
```

## Configuration

### Redis client (required)

Configure Mission Control - Web with a Redis client.

```rb
MissionControl::Web.configuration.redis = Redis.new(url: "redis://server:6379")
```

### Administered applications

By default the name of the current Rails application, and the configured Redis will be used. But you can override this:

```rb
MissionControl::Web.configuration.administered_applications = [ { name: "My Rails App", redis: Redis.new } ]
```

### Disable

Useful for disabling the Mission Control - Web request intercept middleware on a per-application or per-environment basis.

```rb
MissionControl::Web.configuration.enabled = false
```

## Testing
Run:

```sh
rake test
```

Performance tests can be run in the "profile" environment for more consistent results with:

```sh
RAILS_ENV=profile rake test:performance
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
