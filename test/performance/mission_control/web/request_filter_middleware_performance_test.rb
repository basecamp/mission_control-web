require "test_helper"

module MissionControl::Web
  class RequestFilterMiddlewarePerformanceTest < ActionDispatch::IntegrationTest
    test "performance overhead with middleware enabled is less than 5%" do
      baseline = -> {
        MissionControl::Web.configuration.middleware_enabled = false

        get posts_path

        assert_equal 200, status
      }

      assert_slower_by_at_most 1.05, baseline: baseline do
        MissionControl::Web.configuration.middleware_enabled = true

        get posts_path

        assert_equal 200, status
      end
    end

    test "memory overhead with middleware enabled is less than 5%" do
      warmup = -> {
        get posts_path
      }

      baseline = -> {
        MissionControl::Web.configuration.middleware_enabled = false

        get posts_path

        assert_equal 200, status
      }

      assert_uses_more_memory_by_at_most 1.05, warmup: warmup, baseline: baseline do
        MissionControl::Web.configuration.middleware_enabled = true

        get posts_path

        assert_equal 200, status
      end
    end
  end
end
