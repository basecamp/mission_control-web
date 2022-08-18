class MissionControl::Web::Patterns
  attr_accessor :collection

  REDIS_KEY = :mission_control_web_disabled_routes

  def matching?(path)
    collection.keys.any? { |pattern| pattern.match?(path) }
  end

  def disabled
    self.collection = MissionControl::Web.redis.hgetall(REDIS_KEY)
    self
  end

  def disable(pattern)
    MissionControl::Web.redis.hset REDIS_KEY, pattern.to_s, true
  end
end
