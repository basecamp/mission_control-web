class MissionControl::Web::RoutesController < MissionControl::Web::ApplicationController
  before_action :set_route, only: %i[ show edit update destroy ]

  def index
    @routes = MissionControl::Web::Route.all
  end

  def show
  end

  def new
    @route = MissionControl::Web::Route.new
  end

  def edit
  end

  def create
    @route = MissionControl::Web::Route.new(route_params)

    if @route.save
      redirect_to @route, notice: "Route was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @route.update(route_params)
      redirect_to @route, notice: "Route was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @route.destroy

    redirect_to routes_url, notice: "Route was successfully destroyed."
  end

  private
    def set_route
      @route = MissionControl::Web::Route.find(params[:id])
    end

    def route_params
      params.require(:route).permit(:name, :pattern, :enabled)
    end
end
