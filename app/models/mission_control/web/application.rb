class MissionControl::Web::Application
  include ActiveModel::Model

  attr_accessor :name, :redis

  class << self
    def all
      MissionControl::Web.configuration.administered_applications.map { |app| new(**app) }
    end

    def find(id)
      all.find { |application| application.id == id } or raise MissionControl::Web::Errors::ResourceNotFound
    end

    def find_by_name(name)
      find(name.parameterize)
    end

    def default
      all.first or raise MissionControl::Web::Errors::ResourceNotFound
    end
  end

  def id
    name.parameterize
  end

  alias to_param id

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
