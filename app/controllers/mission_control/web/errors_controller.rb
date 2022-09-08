# Each action corresponds to a filter action.
#
# Resolve mission_control/web/errors/action.format.handler in both app
# and engine view paths.
#
# Use request.mission_control in views to provide context about what
# feature is unavailable, etc.

class MissionControl::Web::ErrorsController < ActionController::Base
  before_action { response.status = :service_unavailable }

  def disallowed
  end

  def other
    respond_to do |format|
      format.html
      format.json
    end
  end

  def action_missing(action)
    disallowed
  end
end
