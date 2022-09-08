require "application_system_test_case"

class MissionControl::Web::NavbarTest < ApplicationSystemTestCase
  test "current application selector is rendered" do
    MissionControl::Web.configuration.administered_applications =[
      { name: "Dummy App 1", redis: MissionControl::Web.configuration.redis },
      { name: "Dummy App 2", redis: MissionControl::Web.configuration.redis }
    ]

    visit root_path

    within ".application-selector" do
      assert_selector ".navbar-link", text: "Dummy App"
    end
  end

  test "current application selector is not rendered when there's only one application" do
    visit root_path

    assert_no_selector ".application-selector"
  end
end
