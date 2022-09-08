module MissionControl::Web::Route::Applications
  extend ActiveSupport::Concern

  included do
    after_save    :route_was_updated
    after_destroy :route_was_deleted
  end

  def route_was_updated
    application.route_was_updated(self)
  end

  def route_was_deleted
    application.route_was_deleted(self)
  end
end
