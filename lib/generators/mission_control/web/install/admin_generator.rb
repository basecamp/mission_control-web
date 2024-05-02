require "rails/generators"

module MissionControl::Web
  module Install
    class AdminGenerator < Rails::Generators::Base
      INITIALIZER_FILE_PATH = "config/initializers/mission_control_web.rb"

      def create_initializer_file
        create_file INITIALIZER_FILE_PATH, <<~RUBY, skip: true
          Rails.application.configure do
          end
        RUBY
      end

      def configure_initializer
        initializer = <<~RUBY
          # Admin
          config.mission_control.web.administered_applications = [
            { name: "My App", redis: Redis.new(url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0")) }
          ]
        RUBY

        insert_into_file INITIALIZER_FILE_PATH, indent(initializer), after: "Rails.application.configure do\n"
      end

      def add_engine_routes
        route "mount MissionControl::Web::Engine => '/mission_control-web'"
      end

      def copy_migrations
        rake "mission_control_web:install:migrations"
      end

      def run_migrations
        say "Running migrations..."
        rails_command "db:migrate"
      end
    end
  end
end
