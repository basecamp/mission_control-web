require "test_helper"

class MissionControl::Web::RoutesControllerTest < ActionDispatch::IntegrationTest
  include MissionControl::Web::Engine.routes.url_helpers

  setup do
    @route = mission_control_web_routes(:posts)
    @protected_app_paths = { "/posts" => "^/posts$" }
    MissionControl::Web::RoutesCache.any_instance.stubs(:protected_app_paths).returns(@protected_app_paths)
  end

  test "should get index" do
    get application_routes_url(@route.application)

    assert_response :success
  end

  test "when acting as root path should redirect to first application's routes" do
    get root_url

    assert_redirected_to application_routes_url(MissionControl::Web::Application.default)
  end

  test "should get new" do
    get new_application_route_url(@route.application)
    assert_response :success
    assert_select "select#app_path_select"
  end

  test "should create route with app_path" do
    assert_difference("MissionControl::Web::Route.count") do
      post application_routes_url(@route.application), params: { 
        route: { 
          enabled: @route.enabled, 
          name: @route.name, 
          app_path: "/posts",
          pattern: "^/posts$" 
        } 
      }
    end

    assert_redirected_to application_route_url(@route.application, MissionControl::Web::Route.last)
    assert_equal "/posts", MissionControl::Web::Route.last.app_path
    assert_equal "^/posts$", MissionControl::Web::Route.last.pattern
  end

  test "should create route with custom pattern when no app_path selected" do
    assert_difference("MissionControl::Web::Route.count") do
      post application_routes_url(@route.application), params: { 
        route: { 
          enabled: @route.enabled, 
          name: @route.name, 
          app_path: nil,
          pattern: "/custom/pattern" 
        } 
      }
    end

    assert_redirected_to application_route_url(@route.application, MissionControl::Web::Route.last)
    assert_nil MissionControl::Web::Route.last.app_path
    assert_equal "/custom/pattern", MissionControl::Web::Route.last.pattern
  end

  test "should show route" do
    get application_route_url(@route.application, @route)
    assert_response :success
  end

  test "should get edit" do
    get edit_application_route_url(@route.application, @route)
    assert_response :success
    assert_select "select#app_path_select"
  end

  test "should update route with app_path" do
    patch application_route_url(@route.application, @route), params: { 
      route: { 
        enabled: @route.enabled, 
        name: @route.name, 
        app_path: "/posts",
        pattern: "^/posts$" 
      } 
    }
    assert_redirected_to application_route_url(@route.application, @route)
    @route.reload
    assert_equal "/posts", @route.app_path
    assert_equal "^/posts$", @route.pattern
  end

  test "should update route with custom pattern when no app_path selected" do
    patch application_route_url(@route.application, @route), params: { 
      route: { 
        enabled: @route.enabled, 
        name: @route.name, 
        app_path: nil,
        pattern: "/custom/pattern" 
      } 
    }
    assert_redirected_to application_route_url(@route.application, @route)
    @route.reload
    assert_nil @route.app_path
    assert_equal "/custom/pattern", @route.pattern
  end

  test "should destroy route" do
    assert_difference("MissionControl::Web::Route.count", -1) do
      delete application_route_url(@route.application, @route)
    end

    assert_redirected_to application_routes_url(@route.application)
  end
end
