class MissionControl::Web::Current < ActiveSupport::CurrentAttributes
  attribute :application

  def application=(application)
    super
    MissionControl::Web.current_redis = application.redis
  end
end
