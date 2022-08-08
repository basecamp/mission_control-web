module MissionControl::Web
  class Route
    attr_reader :name, :verb, :path, :pattern

    def initialize(name:, verb:, path: nil, pattern: nil)
      @name, @verb, @path = name, verb, path
      @pattern = path ? path.to_regexp : Regexp.new(pattern)
    end

    class << self
      def all(main_app)
        main_app._routes.routes.map { |route| from_action_dispatch_journey_route(route) }
      end

      def from_action_dispatch_journey_route(route)
        new(name: route.name, verb: route.verb, path: route.path)
      end

      def from_param(encoded)
        new(**JSON.parse(Base64.decode64(encoded)).symbolize_keys)
      end
    end

    def path_description
      path.spec
    end

    def to_param
      Base64.encode64( { name: name, verb: verb, pattern: pattern.to_s }.to_json )
    end

    def pause
      hash = Kredis.hash "mission_control-web"
      hash.update(pattern.to_s => true)
    end
  end
end
