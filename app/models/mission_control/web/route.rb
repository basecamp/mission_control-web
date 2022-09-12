class MissionControl::Web::Route < ApplicationRecord
  include Applications

  validates :name, :pattern, presence: true
  validates :pattern, uniqueness: true

  def application
    @application ||= MissionControl::Web::Application.find!(application_id)
  end

  def disabled?
    !enabled?
  end
end
