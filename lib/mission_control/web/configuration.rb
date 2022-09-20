class MissionControl::Web::Configuration
  include ActiveModel::Attributes, ActiveModel::Dirty

  attribute :host_application_name,      :string
  attribute :middleware_enabled,         :boolean, default: true
  attribute :routes_cache_ttl,           :integer, default: 10.seconds
  attribute :base_controller_class,      :string,  default: "::ApplicationController"

  attr_writer :redis, :administered_applications
  attr_accessor :errors_controller

  alias :middleware_enabled? :middleware_enabled

  def redis
    @redis || raise("Redis client not configured. Configure with MissionControl::Web.configuration.redis = Redis.new")
  end

  def administered_applications
    @administered_applications || []
  end
end
