require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include MissionControl::Web::Engine.routes.url_helpers

  driven_by :rack_test
end
