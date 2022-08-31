require "test_helper"

class MissionControl::Web::DisabledRoutesCacheTest < ActiveSupport::TestCase
  setup do
    @routes = MissionControl::Web::DisabledRoutesCache.new
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
end
