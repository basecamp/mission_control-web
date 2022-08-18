class MissionControl::Web::Routes
  REDIS_KEY = :mission_control_web_disabled_patterns

  def disable(pattern)
    MissionControl::Web.redis.sadd REDIS_KEY, pattern.to_s
  end

  def enable(pattern)
    MissionControl::Web.redis.srem REDIS_KEY, pattern.to_s
  end

  def disabled?(path)
    all_disabled_patterns.any? { |pattern| Regexp.new(pattern) =~ path }
  end

  private
    def all_disabled_patterns
      MissionControl::Web.redis.smembers REDIS_KEY
    end
end
