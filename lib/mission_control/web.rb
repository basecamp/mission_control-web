require "zeitwerk"
loader = Zeitwerk::Loader.new
loader.inflector = Zeitwerk::GemInflector.new(__FILE__)
loader.push_dir(File.expand_path("..", __dir__))
loader.setup

require "mission_control/web/engine"
require "redis"

module MissionControl
  module Web
    mattr_reader :configuration, default: Configuration.new
    mattr_reader :routes, default: Routes.new
    mattr_reader :redis, default: Redis.new
  end
end
