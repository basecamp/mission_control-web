require_relative "lib/mission_control/web/version"

Gem::Specification.new do |spec|
  spec.name        = "mission_control-web"
  spec.version     = MissionControl::Web::VERSION
  spec.authors     = ["Lewis Buckley"]
  spec.email       = ["lewis@37signals.com"]
  spec.homepage    = "TODO"
  spec.summary     = "TODO: Summary of MissionControl::Web."
  spec.description = "TODO: Description of MissionControl::Web."
    spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.3.1"
end
