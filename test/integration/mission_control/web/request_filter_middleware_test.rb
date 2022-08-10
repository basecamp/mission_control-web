require "test_helper"

module MissionControl::Web
  class RequestFilterMiddlewareTest < ActionDispatch::IntegrationTest
    test "requests to disabled routes are disallowed" do
      Route.new(pattern: "\/posts").disable

      get posts_path

      assert_equal 503, status
    end

    test "requests to paths with no route configured are allowed" do
      get posts_path

      assert_equal 200, status
    end

    test "requests to disabled routes are allowed when Mission Control Web is disabled" do
      Route.new(pattern: "\/posts").disable
      MissionControl::Web.configuration.enabled = false

      get posts_path

      assert_equal 200, status
    end
  end
end
