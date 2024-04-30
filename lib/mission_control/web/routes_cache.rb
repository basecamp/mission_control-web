class MissionControl::Web::RoutesCache
  delegate :redis, to: MissionControl::Web

  def initialize(application)
    @application = application
  end

  def put(route)
    remove(route)

    if route.disabled?
      add(route)
    end
  end

  def remove(route)
    redis.srem redis_key, [ route.pattern_previously_was.to_s, route.pattern.to_s ]
  end

  def disabled?(path)
    all_disabled_patterns.any? { |pattern| Regexp.new(pattern) =~ path }
  end

  private
    attr_reader :application

    def add(route)
      redis.sadd redis_key, route.pattern.to_s
    end

    def redis_key
      :"mission_control_web_#{application.id}_disabled_patterns"
    end

    def all_disabled_patterns
      memoize(ttl: MissionControl::Web.configuration.routes_cache_ttl) do
        # Using Redis client rather than Kredis as request interception with a middleware is performance-critical.
        redis.smembers redis_key
      end
    rescue Redis::BaseConnectionError
      []
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
