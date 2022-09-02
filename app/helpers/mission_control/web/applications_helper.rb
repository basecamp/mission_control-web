module MissionControl::Web::ApplicationsHelper
  def application_select_options
    MissionControl::Web::Application.all.map { |app| [ app.name, app.id ] }
  end
end
