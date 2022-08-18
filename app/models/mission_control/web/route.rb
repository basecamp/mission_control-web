class MissionControl::Web::Route < ApplicationRecord
  after_save    :disable_route, if: :disabled?
  after_save    :enable_route,  if: :enabled?
  after_destroy :enable_route

  validates :name, :pattern, presence: true
  validates :pattern, uniqueness: true

  def disabled?
    !enabled?
  end

  private
    def disable_route
      MissionControl::Web.routes.disable(pattern)
    end

    def enable_route
      MissionControl::Web.routes.enable(pattern)
    end
end
