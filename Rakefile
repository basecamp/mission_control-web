require "bundler/setup"

APP_RAKEFILE = File.expand_path("test/dummy/Rakefile", __dir__)
load "rails/tasks/engine.rake"

load "rails/tasks/statistics.rake"

require "bundler/gem_tasks"

require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"].exclude("test/performance/**/*")
  t.verbose = false
end

namespace :test do
  Rake::TestTask.new(:performance) do |t|
    t.libs << "test"
    t.test_files = FileList["test/performance/**/*_test.rb"]
    t.verbose = false
  end
end

task default: :test
