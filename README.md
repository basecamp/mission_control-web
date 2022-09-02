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

```
MissionControl::Web.configuration.redis = Redis.new(url: "redis://server:6379")
```

### Disable

Useful for disabling Mission Control - Web on a per-environment basis.

```
MissionControl::Web.configuration.enabled = false
```

## Testing
Run:

```
rake test
```

Performance tests can be run in the "profile" environment for more consistent results with:

```
RAILS_ENV=profile rake test:performance
```

## Resiliency

If Redis is down (or raises any instance of Redis::BaseConnectionError), Mission Control Web middleware will fail-open.

It's recommended to also consider using a resilient Redis client with a circuit-breaker. See [Semian](https://github.com/Shopify/semian).

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
