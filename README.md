# Mission Control - Web

This gem provides a Rails-based frontend and middleware to deny access to particular parts of your application. This is
especially useful in an incident response scenario such as deployment of unperformant code, or a denial of service
attack.

<img width="952" alt="Screenshot of Mission Control - Web admin UI" src="https://github.com/basecamp/mission_control-web/assets/1773614/5c75a304-820e-4151-882e-f0782211356c">

## How it works

Mission Control - Web can be configured via the admin interface to block requests whose path matched a regex pattern. If
the requested path matches any "Denied" path, it will be blocked with a 503 HTTP status code.

## Usage

You can choose to deploy Mission Control - Web admin and middleware both in the same Rails app, or two separate apps, a
protected Rails app and an admin app.

The benefit of using two separate apps is that if your protected app is attacked or suffers a performance issue, it may
become inaccessible while an admin app does not.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "mission_control-web"
```

And then execute:
```bash
$ bundle
```

then, follow the instructions below for a single app, or a separate admin app.

## Installation in a single app

And then execute:
```bash
$ bin/rails generate mission_control:web:install
```

## Installation with two apps, admin and protected

After adding the `mission_control-web` gem, in your admin app:

```bash
$ bin/rails generate mission_control:web:install:admin
```

and in your protected Rails app:

```bash
$ bin/rails generate mission_control:web:install:middleware
```

## Configuration

### Redis client

Configure Mission Control - Web with a Redis client.

```rb
# config/initializers/mission_control_web.rb

config.mission_control.web.redis = Redis.new(url: "redis://server:6379/0")
```

### Administered applications

```rb
config.mission_control.web.administered_applications = [ { name: "My Rails App", redis: Redis.new(url: "redis://server:6379/0") } ]
```

### Authentication and base controller class

By default, Mission Control's controllers will extend the host app's ApplicationController. If no authentication is
enforced, the admin pages will be available to everyone. You might want to implement some kind of authentication for
this in your app. To make this easier, you can specify a different controller as the base class for Mission Control's
controllers:

```rb
config.mission_control.web.base_controller_class = "AdminController"
```

### Custom "denied" page

You can configure a custom page to show to users when a request is denied by Mission Control - Web. Configure this like
so:

```rb
config.mission_control.web.errors_controller = MissionControl::Web::CustomErrorsController
```

Then, in your application, create a custom errors controller:

```rb
class MissionControl::Web::CustomErrorsController < MissionControl::Web::ErrorsController
  def disallowed
    render file: "public/503.html"
  end
end
```

### Other configuration

Useful for disabling the Mission Control - Web request intercept middleware on a per-application or per-environment basis:

```rb
config.mission_control.web.middleware_enabled = false
```

Denied paths are cached by the middleware and refreshed from Redis on this interval. With this configuration, it takes up to 10 seconds for path denial to take effect:

```rb
config.mission_control.web.routes_cache_ttl = 10.seconds
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

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
