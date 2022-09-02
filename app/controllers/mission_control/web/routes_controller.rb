class MissionControl::Web::RoutesController < MissionControl::Web::ApplicationController
  include MissionControl::Web::ApplicationScoped

  before_action :set_route, only: %i[ show edit update destroy ]

  def index
    @routes = @application.routes
  end

  def show
  end

  def new
    @route = @application.routes.build
  end

  def edit
  end

  def create
    @route = @application.routes.build(route_params)

    if @route.save
      redirect_to [ @application, @route ], notice: "Route was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @route.update(route_params)
      redirect_to [ @route.application, @route ], notice: "Route was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @route.destroy

    redirect_to application_routes_url(@route.application), notice: "Route was successfully destroyed."
  end

  private
    def set_route
      @route = @application.routes.find(params[:id])
    end

    def route_params
      params.require(:route).permit(:mission_control_web_application_id, :name, :pattern, :enabled)
    end
end
