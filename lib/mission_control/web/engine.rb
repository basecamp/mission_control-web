module MissionControl
  module Web
    class Engine < ::Rails::Engine
      isolate_namespace MissionControl::Web

      initializer "mission_control-web.rack_attack" do |app|
        Rack::Attack.blocklist("pause configured requests") do |request|
          hash = Kredis.hash "mission_control-web"
          hash.keys.any? { |pattern| Regexp.new(pattern).match? request.path  }
        end
      end
    end
  end
end
