require "test_helper"
require "ostruct"

class MissionControl::Web::RoutesCacheTest < ActiveSupport::TestCase
  setup do
    @routes = MissionControl::Web::RoutesCache.new(MissionControl::Web::Application.find!("dummy-app"))
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

  test "set_protected_app_paths stores routes in Redis" do
    MissionControl::Web.configuration.redis = fake_redis = FakeRedisWithCallCounter.new
    Rails.application.routes.routes.stubs(:each).yields(
      OpenStruct.new(path: OpenStruct.new(
        spec: OpenStruct.new(to_s: "/posts"),
        to_regexp: OpenStruct.new(to_s: "^/posts$")
      ))
    )

    @routes.set_protected_app_paths

    assert_equal 1, fake_redis.del_call_count
    assert_equal 1, fake_redis.hmset_call_count
    assert_equal "mission_control_web_dummy-app_protected_app_paths", fake_redis.last_hmset_key
    assert_equal [ { "/posts"=> "^/posts$" } ], fake_redis.last_hmset_values
  end

  test "protected_app_paths retrieves routes from Redis" do
    MissionControl::Web.configuration.redis = fake_redis = FakeRedisWithCallCounter.new

    @routes.protected_app_paths

    assert_equal 1, fake_redis.hgetall_call_count
  end

  test "protected_app_paths returns empty hash when Redis is down" do
    MissionControl::Web.configuration.redis = FakeRedisDown.new

    result = @routes.protected_app_paths

    assert_equal({}, result)
  end
end

class FakeRedisWithCallCounter
  class_attribute :smembers_call_count, default: 0
  class_attribute :del_call_count, default: 0
  class_attribute :hmset_call_count, default: 0
  class_attribute :hgetall_call_count, default: 0
  attr_accessor :last_hmset_key, :last_hmset_values

  def smembers(key)
    self.smembers_call_count += 1
    []
  end

  def del(key)
    self.del_call_count += 1
  end

  def hmset(key, *values)
    self.hmset_call_count += 1
    self.last_hmset_key = key
    self.last_hmset_values = values
  end

  def hgetall(key)
    self.hgetall_call_count += 1
    {}
  end

  def flushdb; end
end

class FakeRedisDown
  def smembers(key)
    raise Redis::ConnectionError
  end

  def del(key)
    raise Redis::ConnectionError
  end

  def hmset(key, *values)
    raise Redis::ConnectionError
  end

  def hgetall(key)
    raise Redis::ConnectionError
  end

  def flushdb; end
end
