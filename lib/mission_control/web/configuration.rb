class MissionControl::Web::Configuration
  include ActiveModel::Attributes, ActiveModel::Dirty

  attribute :enabled,          :boolean, default: true
  attribute :routes_cache_ttl, :integer, default: 10.seconds

  attr_writer :redis

  def disabled?
    !enabled
  end

  def redis
    @redis || raise("Redis client not configured. Configure with MissionControl::Web.configuration.redis = Redis.new")
  end
end
