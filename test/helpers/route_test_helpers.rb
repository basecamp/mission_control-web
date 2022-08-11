module RouteTestHelpers
  def disable_route(path)
    MissionControl::Web::Patterns.disable(path)
  end
end
