class MissionControl::Web::InstallGenerator < Rails::Generators::Base
  def install_components
    rails_command "generate mission_control:web:admin_install"
    rails_command "generate mission_control:web:middleware_install"
  end
end
