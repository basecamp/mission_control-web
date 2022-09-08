require "test_helper"

class MissionControl::Web::RoutesCacheTest < ActiveSupport::TestCase
  setup do
    @routes = MissionControl::Web::RoutesCache.new(MissionControl::Web::Application.find("dummy-app"))
    @route = MissionControl::Web::Route.create!(
      application_id: "dummy-app",
      name: "Posts show",
      pattern: "/posts/123",
      enabled: false
    )
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
    MissionControl::Web.configuration.routes_cache_ttl = 10.seconds
    MissionControl::Web.configuration.redis = fake_redis = FakeRedisWithCallCounter.new

    100.times do
      @routes.disabled?("/posts/123")
    end

    assert_equal 1, fake_redis.smembers_call_count
  end

  test "the TTL is respected" do
    MissionControl::Web.configuration.routes_cache_ttl = 10.seconds
    MissionControl::Web.configuration.redis = fake_redis = FakeRedisWithCallCounter.new

    @routes.disabled?("/posts/123")
    travel 11.seconds
    @routes.disabled?("/posts/123")

    assert_equal 2, fake_redis.smembers_call_count
  end

  test "fails open when Redis is down" do
    MissionControl::Web.configuration.redis = FakeRedisDown.new

    assert_not @routes.disabled?("/posts/123")
  end
end

class FakeRedisWithCallCounter
  class_attribute :smembers_call_count, default: 0

  def smembers(key)
    self.smembers_call_count += 1
    []
  end

  def flushdb; end
end

class FakeRedisDown
  def smembers(key)
    raise Redis::ConnectionError
  end

  def flushdb; end
end
