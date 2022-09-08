require "mission_control/web/engine"
require "active_support/core_ext/module/attribute_accessors_per_thread"

require "zeitwerk"
loader = Zeitwerk::Loader.new
loader.inflector = Zeitwerk::GemInflector.new(__FILE__)
loader.push_dir(File.expand_path("..", __dir__))
loader.setup

module MissionControl
  module Web
    mattr_reader :configuration, default: Configuration.new
    thread_mattr_accessor :current_redis

    def self.redis
      current_redis || configuration.redis
    end

    def self.host_application
      @host_application ||= Application.find_by_name(configuration.host_application_name)
    end
  end
end
