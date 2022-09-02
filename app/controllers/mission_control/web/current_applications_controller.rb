class MissionControl::Web::CurrentApplicationsController < ApplicationController
  def update
    redirect_to application_routes_path(params[:current_application_id])
  end
end
