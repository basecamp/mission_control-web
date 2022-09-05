class MissionControl::Web::ApplicationController < MissionControl::Web.configuration.base_controller_class.constantize
  default_form_builder MissionControl::Web::BulmaFormBuilder
  helper MissionControl::Web::ApplicationsHelper
end
