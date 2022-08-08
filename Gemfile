source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
git_source(:bc)     { |repo| "https://github.com/basecamp/#{repo}" }

# Specify your gem's dependencies in mission_control-web.gemspec.
gemspec

gem "sqlite3"
gem "kredis"

gem "puma"
gem "sprockets-rails"

gem "rack-attack"

group :development do
  gem "rubocop-37signals", bc: "house-style", require: false
  gem "web-console"
end

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"
