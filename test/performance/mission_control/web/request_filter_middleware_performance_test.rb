require "test_helper"

module MissionControl::Web
  class RequestFilterMiddlewarePerformanceTest < ActionDispatch::IntegrationTest
    test "performance overhead is less than 10%" do
      baseline = -> { get posts_path }

      assert_slower_by_at_most 1.1, baseline: baseline do
        MissionControl::Web.configuration.enabled = false

        get posts_path
      end
    end
  end
end
