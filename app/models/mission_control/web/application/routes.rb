module MissionControl::Web::Application::Routes
  extend ActiveSupport::Concern

  included do
    delegate :protected_app_paths, :set_protected_app_paths, to: :routes_cache
  end

  def routes
    MissionControl::Web::Route.where(application_id: id)
  end

  def route_was_updated(route)
    routes_cache.put(route)
  end

  def route_was_deleted(route)
    routes_cache.remove(route)
  end

  def route_disabled?(path)
    routes_cache.disabled?(path)
  end

  private
    def routes_cache
      @routes_cache ||= MissionControl::Web::RoutesCache.new(self)
    end
end
