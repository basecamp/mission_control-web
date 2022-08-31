module RouteTestHelpers
  def disable_route(path)
    MissionControl::Web::Route.create!(name: path, pattern: path, enabled: false)
  end
end
