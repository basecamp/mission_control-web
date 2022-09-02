module MissionControl
  module Web
    class Engine < ::Rails::Engine
      isolate_namespace MissionControl::Web

      initializer "mission_control-web.add_middleware" do |app|
        app.middleware.use MissionControl::Web::RequestFilterMiddleware
      end

      config.after_initialize do
        MissionControl::Web.configuration.application_name = ::Rails.application.class.module_parent.to_s

        MissionControl::Web.configuration.administered_applications.each do |application|
          if MissionControl::Web::Application.table_exists?
            MissionControl::Web::Application.find_or_create_by!(name: application[:name])
          end
        end
      end
    end
  end
end
