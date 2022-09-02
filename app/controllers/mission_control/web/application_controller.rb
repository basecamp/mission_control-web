class MissionControl::Web::ApplicationController < ActionController::Base
  default_form_builder MissionControl::Web::BulmaFormBuilder
  helper MissionControl::Web::ApplicationsHelper
end
