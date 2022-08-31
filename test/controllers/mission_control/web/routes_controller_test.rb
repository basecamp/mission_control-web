require "test_helper"

class MissionControl::Web::RoutesControllerTest < ActionDispatch::IntegrationTest
  include MissionControl::Web::Engine.routes.url_helpers

  setup do
    @route = mission_control_web_routes(:posts)
  end

  test "should get index" do
    get routes_url
    assert_response :success
  end

  test "should get new" do
    get new_route_url
    assert_response :success
  end

  test "should create route" do
    assert_difference("MissionControl::Web::Route.count") do
      post routes_url, params: { route: { enabled: @route.enabled, name: @route.name, pattern: "/posts/123" } }
    end

    assert_redirected_to route_url(MissionControl::Web::Route.last)
  end

  test "should show route" do
    get route_url(@route)
    assert_response :success
  end

  test "should get edit" do
    get edit_route_url(@route)
    assert_response :success
  end

  test "should update route" do
    patch route_url(@route), params: { route: { enabled: @route.enabled, name: @route.name, pattern: @route.pattern } }
    assert_redirected_to route_url(@route)
  end

  test "should destroy route" do
    assert_difference("MissionControl::Web::Route.count", -1) do
      delete route_url(@route)
    end

    assert_redirected_to routes_url
  end
end
