module MissionControl::Web
  class Request < Rack::Request
    def disallowed?
      Patterns.disabled.matching?(path)
    end
  end
end
