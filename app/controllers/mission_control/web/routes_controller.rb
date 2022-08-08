module MissionControl::Web
  class RoutesController < ApplicationController
    before_action :set_route, only: [ :pause, :resume ]

    def index
      @routes = Route.all(main_app)
    end

    def pause
      @route.pause
      redirect_to routes_path, notice: "Route paused."
    end

    def resume

    end

    private
      def set_route
        @route = Route.from_param(params[:id])
      end
  end
end
