module MissionControl::Web::Route::DisabledRoutes
  extend ActiveSupport::Concern

  included do
    class_attribute :disabled_routes_cache, default: MissionControl::Web::DisabledRoutesCache.new

    after_save    :disable_route, if: :disabled?
    after_save    :enable_route,  if: :enabled?
    after_destroy :enable_route
  end

  class_methods do
    def disabled?(pattern)
      disabled_routes_cache.disabled?(pattern)
    end
  end

  private
    def disable_route
      disabled_routes_cache.upsert(self)
    end

    def enable_route
      disabled_routes_cache.remove(self)
    end
end
