class MissionControl::Web::RoutesCache
  delegate :redis, to: MissionControl::Web

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
    redis.srem redis_key, route.pattern.to_s
  end

  def disabled?(path)
    all_disabled_patterns.any? { |pattern| Regexp.new(pattern) =~ path }
  end

  private
    attr_reader :application_name

    def add(route)
      redis.sadd redis_key, route.pattern.to_s
    end

    def all_disabled_patterns
      # Using Redis client rather than Kredis as request interception with a middlware is performance-critical.
      redis.smembers redis_key
    end

    def redis_key
      "mission_control_web_#{application_name.underscore}_disabled_patterns"
    end
end
