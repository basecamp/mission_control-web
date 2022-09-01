class MissionControl::Web::Route < ApplicationRecord
  include DisabledRoutes

  belongs_to :mission_control_web_application, class_name: "MissionControl::Web::Application"

  validates :name, :pattern, presence: true
  validates :pattern, uniqueness: true

  def disabled?
    !enabled?
  end
end
