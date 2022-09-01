class MissionControl::Web::Application < ApplicationRecord
  has_many :routes, class_name: "MissionControl::Web::Route", foreign_key: "mission_control_web_application_id"
end
