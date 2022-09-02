require "test_helper"

class MissionControl::Web::RoutesControllerTest < ActionDispatch::IntegrationTest
  include MissionControl::Web::Engine.routes.url_helpers

  setup do
    @route = mission_control_web_routes(:posts)
  end

  test "should get index" do
    get application_routes_url(@route.application)

    assert_response :success
  end

  test "when acting as root path should redirect to first application's routes" do
    get root_url

    assert_redirected_to application_routes_url(MissionControl::Web::Application.first)
  end

  test "should get new" do
    get new_application_route_url(@route.application)
    assert_response :success
  end

  test "should create route" do
    assert_difference("MissionControl::Web::Route.count") do
      post application_routes_url(@route.application), params: { route: { enabled: @route.enabled, name: @route.name, pattern: "/posts/123" } }
    end

    assert_redirected_to application_route_url(@route.application, MissionControl::Web::Route.last)
  end

  test "should show route" do
    get application_route_url(@route.application, @route)
    assert_response :success
  end

  test "should get edit" do
    get edit_application_route_url(@route.application, @route)
    assert_response :success
  end

  test "should update route" do
    patch application_route_url(@route.application, @route), params: { route: { enabled: @route.enabled, name: @route.name, pattern: @route.pattern } }
    assert_redirected_to application_route_url(@route.application, @route)
  end

  test "should destroy route" do
    assert_difference("MissionControl::Web::Route.count", -1) do
      delete application_route_url(@route.application, @route)
    end

    assert_redirected_to application_routes_url(@route.application)
  end
end
