class MissionControl::Web::ErrorsController < ActionController::Base
  before_action { response.status = :service_unavailable }

  def disallowed
  end
end
