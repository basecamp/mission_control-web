module MissionControl::Web
  class RoutesController < ApplicationController
    def index
      @routes = main_app._routes.routes
    end
  end
end
