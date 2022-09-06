module MissionControl::Web
  class RequestFilterMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      return @app.call(env) unless MissionControl::Web.configuration.middleware_enabled?

      request = Request.new(env)

      if request.disallowed?
        [ 503, {}, [ "Unavailable" ] ]
      else
        @app.call(env)
      end
    end
  end
end
