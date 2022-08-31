module MissionControl::Web::Route::DisabledRoutes
  extend ActiveSupport::Concern

  included do
    class_attribute :disabled_routes_cache, default: MissionControl::Web::DisabledRoutesCache.new

    after_save    :update_in_cache
    after_destroy :remove_from_cache
  end

  class_methods do
    def disabled?(pattern)
      disabled_routes_cache.disabled?(pattern)
    end
  end

  private
    def update_in_cache
      disabled_routes_cache.put(self)
    end

    def remove_from_cache
      disabled_routes_cache.remove(self)
    end
end
