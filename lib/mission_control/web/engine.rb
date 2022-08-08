module MissionControl
  module Web
    class Engine < ::Rails::Engine
      isolate_namespace MissionControl::Web
    end
  end
end
