require "test_helper"

module MissionControl::Web
  class RouteTest < ActiveSupport::TestCase
    setup do
      @route = Route.create!(name: "Chat", pattern: "/campfire", enabled: false)
    end

    test "creating a Route configures the routes" do
      assert MissionControl::Web.routes.disabled? "/campfire"
    end

    test "updating the Route to be enabled removes the routes configuration" do
      @route.update!(enabled: true)

      assert_not MissionControl::Web.routes.disabled? "/campfire"
    end

    test "destroying a Route removes the routes configuration" do
      @route.destroy!

      assert_not MissionControl::Web.routes.disabled? "/campfire"
    end
  end
end
