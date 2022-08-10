require "test_helper"

module MissionControl::Web
  class RequestFilterMiddlewarePerformanceTest < ActionDispatch::IntegrationTest
    test "performance overhead with middlware enabled is less than 30%" do
      baseline = -> {
        MissionControl::Web.configuration.enabled = false

        get posts_path
      }

      assert_slower_by_at_most 1.3, baseline: baseline do
        MissionControl::Web.configuration.enabled = true

        get posts_path
      end
    end
  end
end
