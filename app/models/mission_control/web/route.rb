class MissionControl::Web::Route < ApplicationRecord
  include DisabledRoutes

  validates :name, :pattern, presence: true
  validates :pattern, uniqueness: true

  attr_accessor :application

  def application
    @application || MissionControl::Web::Application.find(application_id)
  end

  def disabled?
    !enabled?
  end
end
