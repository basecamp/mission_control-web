module MissionControl::Web
  module ActionDispatchRequest
    def mission_control
      MissionControl::Web::RequestFilter.new(self)
    end
  end
end
