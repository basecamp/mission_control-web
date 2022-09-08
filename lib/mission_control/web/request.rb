module MissionControl::Web
  class Request
    attr_reader :path

    def initialize(env)
      @path = env["SCRIPT_NAME"] + env["PATH_INFO"]
    end
  end
end
