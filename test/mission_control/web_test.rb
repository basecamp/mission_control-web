require "test_helper"

class MissionControl::WebTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert MissionControl::Web::VERSION
  end

  test "Redis can be configured" do
    MissionControl::Web.configuration.redis = redis = Redis.new(host: "0100::/64") # IPv6 black hole

    redis.expects(:smembers).returns([])

    MissionControl::Web.host_application.route_disabled?("/posts/123")
  end

  test "administered applications are not required" do
    MissionControl::Web.configuration.administered_applications = []
    MissionControl::Web.configuration.host_application_name = "Dummy App"

    assert_equal "Dummy App", MissionControl::Web.host_application.name
  end
end
