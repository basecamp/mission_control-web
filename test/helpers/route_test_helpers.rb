module RouteTestHelpers
  def disable_route(path)
    MissionControl::Web::Route.create!(
      mission_control_web_application_id: ActiveRecord::FixtureSet.identify(:dummy_app),
      name: path,
      pattern: path,
      enabled: false
    )
  end
end
