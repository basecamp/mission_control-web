require "test_helper"

class MissionControl::Web::RoutesTest < ActiveSupport::TestCase
  setup do
    @routes = MissionControl::Web::Routes.new
    @pattern = "/posts"
  end

  test "disabled after disabling a pattern" do
    @routes.disable(@pattern)

    assert @routes.disabled?("/posts/123")
  end

  test "not disabled after enabling a pattern" do
    @routes.disable(@pattern)
    @routes.enable(@pattern)

    assert_not @routes.disabled?("/posts/123")
  end
end
