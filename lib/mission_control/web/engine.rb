require "importmap-rails"
require "turbo-rails"

module MissionControl
  module Web
    class Engine < ::Rails::Engine
      isolate_namespace MissionControl::Web

      config.mission_control = ActiveSupport::OrderedOptions.new
      config.mission_control.web = ActiveSupport::OrderedOptions.new

      initializer "mission_control-web.config" do
        config.mission_control.web.each do |key, value|
          MissionControl::Web.configuration.public_send("#{key}=", value)
        end
      end

      initializer "mission_control-web.add_middleware" do |app|
        app.middleware.use MissionControl::Web::RequestFilterMiddleware
      end

      initializer "mission_control-web.assets" do |app|
        app.config.assets.paths << root.join("app/javascript")
        app.config.assets.precompile += %w[ mission_control_web_manifest ]
      end

      initializer "mission_control-web.importmap", before: "importmap" do |app|
        app.config.importmap.paths << root.join("config/importmap.rb")
        app.config.importmap.cache_sweepers << root.join("app/javascript")
      end

      config.after_initialize do
        MissionControl::Web.configuration.administered_applications.each do |application|
          if MissionControl::Web::Application.table_exists?
            MissionControl::Web::Application.find_or_create_by!(name: application[:name])
          end
        end
      end
    end
  end
end
