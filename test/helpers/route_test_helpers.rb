module RouteTestHelpers
  def disable_route(path)
    MissionControl::Web.patterns.disable(path)
  end
end
