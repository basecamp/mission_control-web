require "test_helper"

class MissionControl::Web::BaseApplicationControllerTest < ActiveSupport::TestCase
  test "engine's ApplicationController inherits from host's ApplicationController by default" do
    assert MissionControl::Web::ApplicationController < ApplicationController
  end
end
