module MissionControl::Web
  class Request < Rack::Request
    def disallowed?
      Route.disabled.any? { |route| route.match? path }
    end
  end
end
