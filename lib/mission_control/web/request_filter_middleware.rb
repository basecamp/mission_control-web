module MissionControl::Web
  class RequestFilterMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      return @app.call(env) unless MissionControl::Web.configuration.middleware_enabled?

      request = Request.new(env)

      if request.disallowed?
        if MissionControl::Web.configuration.middleware_raises_error?
          raise MissionControl::Web::Errors::ServiceUnavailable
        else
          [ 503, {}, [ "Unavailable" ] ]
        end
      else
        @app.call(env)
      end
    end
  end
end
