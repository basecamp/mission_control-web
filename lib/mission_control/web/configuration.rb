class MissionControl::Web::Configuration
  include ActiveModel::Attributes, ActiveModel::Dirty

  attribute :middleware_enabled,         :boolean, default: true
  attribute :middleware_serves_503_page, :boolean, default: true
  attribute :routes_cache_ttl,           :integer, default: 10.seconds
  attribute :base_controller_class,      :string,  default: "::ApplicationController"

  attr_writer :redis, :administered_applications

  alias :middleware_enabled? :middleware_enabled
  alias :middleware_serves_503_page? :middleware_serves_503_page

  def redis
    @redis || raise("Redis client not configured. Configure with MissionControl::Web.configuration.redis = Redis.new")
  end

  def administered_applications
    @administered_applications || []
  end
end
