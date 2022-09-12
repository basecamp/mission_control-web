class MissionControl::Web::Application
  include ActiveModel::Model
  include Routes

  attr_accessor :name, :redis

  class << self
    def all
      MissionControl::Web.configuration.administered_applications.map { |app| new(**app) }
    end

    def find(id)
      all.find { |application| application.id == id }
    end

    def find!(id)
      find(id) or raise MissionControl::Web::Errors::ResourceNotFound
    end

    def find_or_initialize_by_name(name)
      find(name.parameterize) || new(name: name)
    end

    def default
      all.first or raise MissionControl::Web::Errors::ResourceNotFound
    end
  end

  def id
    name.parameterize
  end

  alias to_param id
end
