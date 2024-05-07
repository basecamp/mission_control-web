module MissionControl::Web::Install
  class MissionControl::Web::Install::MiddlewareGenerator < Rails::Generators::Base
    INITIALIZER_FILE_PATH = "config/initializers/mission_control_web.rb"

    def create_initializer_file
      create_file INITIALIZER_FILE_PATH, <<~RUBY, skip: true
        Rails.application.configure do
        end
      RUBY
    end

    def configure_initializer
      initializer = <<~RUBY
        # Middleware
        config.mission_control.web.host_application_name = "My App"
        config.mission_control.web.redis = Redis.new(url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0"))
      RUBY

      insert_into_file INITIALIZER_FILE_PATH, indent(initializer), after: "Rails.application.configure do\n"
    end
  end
end
