module RouteTestHelpers
  def disable_route(path)
    MissionControl::Web.routes.disable(path)
  end
end
