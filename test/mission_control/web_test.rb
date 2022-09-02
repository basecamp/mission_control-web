require "test_helper"

class MissionControl::WebTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert MissionControl::Web::VERSION
  end

  test "Redis can be configured" do
    MissionControl::Web.configuration.redis = redis = Redis.new(host: "0100::/64") # IPv6 black hole

    redis.expects(:smembers).returns([])

    MissionControl::Web::Route.disabled?("/posts/123")
  end
end
