require "application_system_test_case"

class MissionControl::Web::ErrorsTest < ApplicationSystemTestCase
  test "error page" do
    disable_route "/posts/123"

    visit post_path(123)

    assert_text "Service temporarily unavailable. Try again in a few minutes."
  end
end
