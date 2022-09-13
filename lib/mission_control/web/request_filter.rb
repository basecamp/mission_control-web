module MissionControl::Web
  class RequestFilter
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def action
      request.fetch_header("mission_control.action") do
        if MissionControl::Web.host_application.route_disabled?(request.path)
          :disallowed
        end
      end
    end
  end
end
