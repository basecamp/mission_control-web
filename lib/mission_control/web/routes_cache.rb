class MissionControl::Web::RoutesCache
  REDIS_KEY = :mission_control_web_disabled_patterns

  def put(route)
    if route.disabled?
      add(route)
    else
      remove(route)
    end
  end

  def remove(route)
    MissionControl::Web.redis.srem REDIS_KEY, route.pattern.to_s
  end

  def disabled?(path)
    all_disabled_patterns.any? { |pattern| Regexp.new(pattern) =~ path }
  end

  private
    def add(route)
      MissionControl::Web.redis.sadd REDIS_KEY, route.pattern.to_s
    end

    def all_disabled_patterns
      memoize(ttl: MissionControl::Web.configuration.routes_cache_ttl) do
        # Using Redis client rather than Kredis as request interception with a middleware is performance-critical.
        MissionControl::Web.redis.smembers REDIS_KEY
      end
    end

    def memoize(ttl:)
      if !@patterns.nil? && @patterns_expires_at > Time.now
        @patterns
      else
        @patterns_expires_at = Time.now + ttl
        @patterns = yield
      end
    end
end
