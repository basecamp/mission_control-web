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

  def set_protected_app_paths
    redis.del protected_app_paths_redis_key

    redis.hmset protected_app_paths_redis_key, build_protected_app_path_hash
  end

  def protected_app_paths
    redis.hgetall protected_app_paths_redis_key
  rescue Redis::BaseConnectionError
    {}
  end

  private
    attr_reader :application

    def add(route)
      redis.sadd redis_key, route.pattern.to_s
    end

    def redis_key
      :"mission_control_web_#{application.id}_disabled_patterns"
    end

    def protected_app_paths_redis_key
      "mission_control_web_#{application.id}_protected_app_paths"
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

    def build_protected_app_path_hash
      routes_hash = {}
      Rails.application.routes.routes.each do |route|
        path_spec = route.path.spec.to_s
        regexp_string = route.path.to_regexp.to_s
        routes_hash[path_spec] = regexp_string
      end
      routes_hash.to_a.uniq(&:first).to_h
    end
end
