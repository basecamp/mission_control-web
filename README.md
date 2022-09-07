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
# application.rb

config.mission_control.web.redis = Redis.new(url: "redis://server:6379")
```

### Administered applications

```rb
config.mission_control.web.administered_applications = [ { name: "My Rails App", redis: Redis.new } ]
```

### Raise exceptions

Rather than return 503 Service Unavailable you can configure Mission Control - Web to raise an exception instead. This
will bubble up to be handled by Rails exception handling. You can then create a custom error page in "public/503.html"
that your Rails app will serve when Mission Control - Web blocks requests.

```rb
config.mission_control.web.middleware_serves_503_page = false
```

### Disable Middleware

Useful for disabling the Mission Control - Web request intercept middleware on a per-application or per-environment basis.

```rb
config.mission_control.web.middleware_enabled = false
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

## Resiliency

If Redis is down (or raises any instance of Redis::BaseConnectionError), Mission Control Web middleware will fail-open.

It's recommended to also consider using a resilient Redis client with a circuit-breaker. See [Semian](https://github.com/Shopify/semian).

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
