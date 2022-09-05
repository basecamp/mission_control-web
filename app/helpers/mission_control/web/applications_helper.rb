module MissionControl::Web::ApplicationsHelper
  def selectable_applications
    MissionControl::Web::Application.all.reject { |app| selected_application?(app) }
  end

  def selected_application?(application)
    MissionControl::Web::Current.application.name == application.name
  end
end
