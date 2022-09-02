module MissionControl::Web::ApplicationScoped
  extend ActiveSupport::Concern

  included do
    before_action :ensure_application_scope
    before_action :set_application
  end

  private
    def ensure_application_scope
      redirect_to application_routes_path(MissionControl::Web::Application.first) unless params[:application_id]
    end

    def set_application
      MissionControl::Web::Current.application = @application = MissionControl::Web::Application.find(params[:application_id])
    end
end
