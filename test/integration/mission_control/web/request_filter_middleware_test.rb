require "test_helper"

module MissionControl::Web
  class RequestFilterMiddlewareTest < ActionDispatch::IntegrationTest
    test "requests to disabled routes are disallowed" do
      disable_route "/posts/123"

      get post_path(123)

      assert_equal 503, status
    end

    test "requests to paths with no route configured are allowed" do
      get post_path(456)

      assert_equal 200, status
    end

    test "requests to disabled routes are allowed when Mission Control Web is disabled" do
      MissionControl::Web.configuration.middleware_enabled = false
      disable_route "/posts/123"

      get post_path(123)

      assert_equal 200, status
    end
  end
end
