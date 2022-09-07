module MissionControl::Web
  class RequestFilterMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      return @app.call(env) unless MissionControl::Web.configuration.middleware_enabled?

      request = Request.new(env)

      if request.disallowed?
        if MissionControl::Web.configuration.middleware_serves_503_page?
          [ 503, {}, [ "Unavailable" ] ]
        else
          raise MissionControl::Web::Errors::ServiceUnavailable
        end
      else
        @app.call(env)
      end
    end
  end
end
