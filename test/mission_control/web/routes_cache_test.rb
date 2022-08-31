require "test_helper"

class MissionControl::Web::RoutesCacheTest < ActiveSupport::TestCase
  setup do
    @routes = MissionControl::Web::RoutesCache.new
    @route = MissionControl::Web::Route.new(pattern: "/posts/123", enabled: false)
  end

  test "disabled after disabling a route" do
    @routes.put(@route)

    assert @routes.disabled?("/posts/123")
  end

  test "not disabled after enabling a route" do
    @routes.put(@route)
    @routes.remove(@route)

    assert_not @routes.disabled?("/posts/123")
  end

  test "Redis access is cached with a TTL" do
    @@smembers_call_count = 0

    original_cache_ttl = MissionControl::Web.configuration.cache_ttl
    MissionControl::Web.configuration.cache_ttl = 10.seconds
    MissionControl::Web.configuration.redis = Class.new do
      def smembers(key)
        @@smembers_call_count += 1
        []
      end

      def flushdb; end
    end.new

    100.times do
      @routes.disabled?("/posts/123")
    end

    assert_equal 1, @@smembers_call_count

    MissionControl::Web.configuration.cache_ttl = original_cache_ttl
  end
end
