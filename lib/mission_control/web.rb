require "zeitwerk"
loader = Zeitwerk::Loader.new
loader.tag = "mission_control-web"
loader.inflector = Zeitwerk::GemInflector.new(__FILE__)
loader.push_dir(File.expand_path("..", __dir__))
loader.setup

require "mission_control/web/engine"

module MissionControl
  module Web
    def self.configuration
      @configuration ||= Configuration.new
    end
  end
end
