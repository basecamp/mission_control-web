module RouteTestHelpers
  def disable_route(path)
    MissionControl::Web::Route.new(pattern: path).disable
  end
end
