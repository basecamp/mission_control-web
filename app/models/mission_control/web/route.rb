class MissionControl::Web::Route < ApplicationRecord
  include DisabledRoutes

  belongs_to :application, class_name: "MissionControl::Web::Application", foreign_key: "mission_control_web_application_id"

  validates :name, :pattern, presence: true
  validates :pattern, uniqueness: true

  def disabled?
    !enabled?
  end
end
