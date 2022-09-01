class MissionControl::Web::Route < ApplicationRecord
  include DisabledRoutes

  belongs_to :application

  validates :name, :pattern, presence: true
  validates :pattern, uniqueness: true

  def disabled?
    !enabled?
  end
end
