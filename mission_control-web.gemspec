require_relative "lib/mission_control/web/version"

Gem::Specification.new do |spec|
  spec.name = "mission_control-web"
  spec.version = MissionControl::Web::VERSION
  spec.authors = [ "Lewis Buckley" ]
  spec.email = [ "lewis@hey.com" ]
  spec.homepage = "https://github.com/basecamp/mission_control-web"
  spec.summary = "Operational controls for Rails web traffic"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.3.1"
  spec.add_dependency "importmap-rails"
  spec.add_dependency "turbo-rails", "< 7" # "< 7" is a fix for the yanked turbo-rails 7.x versions
  spec.add_dependency "redis"

  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rails"
end
