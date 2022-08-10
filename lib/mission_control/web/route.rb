class MissionControl::Web::Route
  def initialize(pattern:)
    @pattern = Regexp.new(pattern)
  end

  def self.disabled
    route_patterns.to_h.map { |route_pattern, _value| new(pattern: route_pattern) }
  end

  def self.route_patterns
    Kredis.hash :mission_control_web_routes
  end

  delegate :match?, to: :pattern

  def disable
    self.class.route_patterns.update(pattern => true)
  end

  private
    attr_reader :pattern
end
