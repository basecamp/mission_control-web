# Configure Rails Environment
require "securerandom"

ENV["RAILS_ENV"] ||= "test"
ENV["SECRET_KEY_BASE"] ||= SecureRandom.hex(10)

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [ File.expand_path("../test/dummy/db/migrate", __dir__) ]
ActiveRecord::Migrator.migrations_paths << File.expand_path("../db/migrate", __dir__)
require "rails/test_help"
require "helpers/performance_test_helpers"
require "helpers/route_test_helpers"

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("fixtures", __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end

class ActiveSupport::TestCase
  include RouteTestHelpers, PerformanceTestHelpers

  setup do
    MissionControl::Web.configuration.redis = Redis.new(url: "redis://localhost:6379/15")
  end

  teardown do
    MissionControl::Web.configuration.restore_attributes

    MissionControl::Web.redis.flushdb
  end
end
