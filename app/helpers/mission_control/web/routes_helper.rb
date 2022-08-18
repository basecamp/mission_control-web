module MissionControl::Web::RoutesHelper
  def route_status_tag(enabled)
    if enabled
      tag.span "Allowed", class: "tag is-success"
    else
      tag.span "Denied", class: "tag is-danger"
    end
  end
end
