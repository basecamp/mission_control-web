require "test_helper"

module MissionControl::Web
  class RequestFilterMiddlewarePerformanceTest < ActionDispatch::IntegrationTest
    test "performance overhead with middlware enabled is less than 35%" do
      baseline = -> {
        MissionControl::Web.configuration.enabled = false

        get posts_path
      }

      assert_slower_by_at_most 1.35, baseline: baseline do
        MissionControl::Web.configuration.enabled = true

        get posts_path
      end
    end
  end
end
