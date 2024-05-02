require "rails/generators"

class MissionControl::Web::InstallGenerator < Rails::Generators::Base
  def install_components
    rails_command "generate mission_control:web:install:admin"
    rails_command "generate mission_control:web:install:middleware"
  end
end
