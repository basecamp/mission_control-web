module MissionControl::Web::RoutesHelper
  def route_status_tag(enabled)
    if enabled
      tag.span "Enabled", class: "tag is-success"
    else
      tag.span "Disabled", class: "tag is-danger"
    end
  end
end
