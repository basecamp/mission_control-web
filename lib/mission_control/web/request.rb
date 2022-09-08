module MissionControl::Web
  class Request
    def initialize(env)
      @path = env["SCRIPT_NAME"] + env["PATH_INFO"]
    end

    def disallowed?
      MissionControl::Web.host_application.route_disabled?(@path)
    end
  end
end
