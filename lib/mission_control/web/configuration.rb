class MissionControl::Web::Configuration
  include ActiveModel::Attributes, ActiveModel::Dirty

  attribute :enabled,               :boolean, default: true
  attribute :routes_cache_ttl,      :integer, default: 10.seconds
  attribute :host_application_name, :string

  attr_writer :redis, :administered_applications

  def disabled?
    !enabled
  end

  def redis
    @redis || raise("Redis client not configured. Configure with MissionControl::Web.configuration.redis = Redis.new")
  end

  def administered_applications
    @administered_applications || [ default_host_app ]
  end

  private
    def default_host_app
      { name: host_application_name, redis: redis }
    end
end
