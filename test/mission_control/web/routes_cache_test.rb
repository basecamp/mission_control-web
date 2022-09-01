require "test_helper"

class MissionControl::Web::RoutesCacheTest < ActiveSupport::TestCase
  setup do
    @routes = MissionControl::Web::RoutesCache.new
    @route = MissionControl::Web::Route.create!(
      application: MissionControl::Web::Application.new(name: "Dummy"),
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
end
