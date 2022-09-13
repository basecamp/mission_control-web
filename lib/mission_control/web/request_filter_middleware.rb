module MissionControl::Web
  class RequestFilterMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      filter(env) || @app.call(env)
    end

    def filter(env)
      return unless MissionControl::Web.configuration.middleware_enabled?

      request = ActionDispatch::Request.new(env)

      if action = request.mission_control.action
        errors_controller.action(action).call(request.env)
      end
    end

    private
      def errors_controller
        MissionControl::Web.configuration.errors_controller || MissionControl::Web::ErrorsController
      end
  end
end
