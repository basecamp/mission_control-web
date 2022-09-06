class MissionControl::Web::Application
  include ActiveModel::Model

  attr_accessor :name, :redis

  class << self
    def all
      MissionControl::Web.configuration.administered_applications.map { |app| new(**app) }
    end

    def find(id)
      all.find { |application| application.id == id }
    end

    def first!
      all.first || raise(MissionControl::Web::Errors::ResourceNotFound)
    end
  end

  def id
    name.parameterize
  end

  alias to_param id

  def routes
    MissionControl::Web::Route.where(application_id: id)
  end
end
