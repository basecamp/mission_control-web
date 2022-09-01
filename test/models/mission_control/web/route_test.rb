require "test_helper"

class MissionControl::Web::RouteTest < ActiveSupport::TestCase
  setup do
    @route = MissionControl::Web::Route.create!(
      mission_control_web_application_id: ActiveRecord::FixtureSet.identify(:dummy_app),
      name: "Chat",
      pattern: "/campfire",
      enabled: false
    )
  end

  test "creating a Route configures the routes" do
    assert MissionControl::Web::Route.disabled? "/campfire"
  end

  test "updating the Route to be enabled removes the routes configuration" do
    @route.update!(enabled: true)

    assert_not MissionControl::Web::Route.disabled? "/campfire"
  end

  test "destroying a Route removes the routes configuration" do
    @route.destroy!

    assert_not MissionControl::Web::Route.disabled? "/campfire"
  end
end
