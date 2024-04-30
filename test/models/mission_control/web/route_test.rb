require "test_helper"

class MissionControl::Web::RouteTest < ActiveSupport::TestCase
  setup do
    @route = MissionControl::Web::Route.create!(
      application_id: "dummy-app",
      name: "Chat",
      pattern: "/campfire",
      enabled: false
    )
  end

  test "creating a Route configures the routes" do
    assert MissionControl::Web.host_application.route_disabled? "/campfire"
  end

  test "updating the Route to be enabled removes the routes configuration" do
    @route.update!(enabled: true)

    assert_not MissionControl::Web.host_application.route_disabled? "/campfire"
  end

  test "updating a Route with a new pattern deletes the old pattern" do
    @route.update!(pattern: "/chat")

    assert_not MissionControl::Web.host_application.route_disabled? "/campfire"
    assert MissionControl::Web.host_application.route_disabled? "/chat"
  end

  test "destroying a Route removes the routes configuration" do
    @route.destroy!

    assert_not MissionControl::Web.host_application.route_disabled? "/campfire"
  end
end
