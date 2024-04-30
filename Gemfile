source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
git_source(:bc)     { |repo| "https://github.com/basecamp/#{repo}" }

gemspec

gem "sqlite3", "~> 1.4"

gem "sprockets-rails"

gem "rubocop-37signals", bc: "house-style", require: false

group :development do
  gem "web-console"
end

group :development, :test, :profile do
  gem "byebug"
  gem "puma"
  gem "redis"
end

group :test, :profile do
  gem "benchmark-ips"
  gem "benchmark-memory"
  gem "mocha"
  gem "capybara"
end
