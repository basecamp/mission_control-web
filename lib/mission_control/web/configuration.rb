class MissionControl::Web::Configuration
  include ActiveModel::Attributes, ActiveModel::Dirty

  attribute :enabled, :boolean, default: true
  attribute :application_name, :string

  attr_writer :redis
  attr_accessor :administered_applications

  def disabled?
    !enabled
  end

  def redis
    @redis || raise("Redis client not configured. Configure with MissionControl::Web.configuration.redis = Redis.new")
  end
end
