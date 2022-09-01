class MissionControl::Web::RoutesCache
  def initialize(application_name: MissionControl::Web.configuration.application_name)
    @application_name = application_name
  end

  def put(route)
    if route.disabled?
      add(route)
    else
      remove(route)
    end
  end

  def remove(route)
    application_redis.srem redis_key, route.pattern.to_s
  end

  def disabled?(path)
    all_disabled_patterns.any? { |pattern| Regexp.new(pattern) =~ path }
  end

  private
    attr_reader :application_name

    def add(route)
      application_redis.sadd redis_key, route.pattern.to_s
    end

    def application_redis
      MissionControl::Web.configuration.administered_applications.
        detect { |application| application[:name] == application_name }&.dig(:redis)
    end

    def redis_key
      "mission_control_web_#{application_name.parameterize}_disabled_patterns"
    end

    def all_disabled_patterns
      memoize(ttl: MissionControl::Web.configuration.routes_cache_ttl) do
        # Using Redis client rather than Kredis as request interception with a middleware is performance-critical.
        MissionControl::Web.redis.smembers redis_key
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
