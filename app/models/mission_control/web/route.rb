class MissionControl::Web::Route < ApplicationRecord
  include DisabledRoutes

  validates :name, :pattern, presence: true
  validates :pattern, uniqueness: true

  def disabled?
    !enabled?
  end
end
