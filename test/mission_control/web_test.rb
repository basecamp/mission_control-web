require "test_helper"

class MissionControl::WebTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert MissionControl::Web::VERSION
  end

  test "Redis can be configured" do
    original_redis = MissionControl::Web.configuration.redis

    MissionControl::Web.configuration.redis = Redis.new(host: "0100::/64") # try to connect to the IPv6 black hole

    assert_raises(Redis::CannotConnectError) do
      MissionControl::Web::Route.disabled?("/posts/123")
    end

    MissionControl::Web.configuration.redis = original_redis
  end
end
