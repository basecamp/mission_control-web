module MissionControl
  module Web
    class Engine < ::Rails::Engine
      isolate_namespace MissionControl::Web

      initializer "mission_control-web.add_middleware" do |app|
        app.middleware.use MissionControl::Web::RequestFilterMiddleware
      end
    end
  end
end
