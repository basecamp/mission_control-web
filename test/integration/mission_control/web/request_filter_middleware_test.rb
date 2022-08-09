require "test_helper"

module MissionControl::Web
  class RequestFilterMiddlewareTest < ActionDispatch::IntegrationTest
    test "requests to disabled routes are disallowed" do
      Route.new(pattern: "\/posts(.*)").disable

      get posts_path

      assert_equal 503, status
    end
  end
end
