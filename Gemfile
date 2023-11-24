# frozen_string_literal: true

ruby file: ".ruby-version"

source "https://rubygems.org"

gemspec

group :quality do
  gem "caliber", "~> 0.42"
  gem "git-lint", "~> 6.0"
  gem "reek", "~> 6.1", require: false
  gem "simplecov", "~> 0.22", require: false
end

group :development do
  gem "rake", "~> 13.0"
end

group :test do
  gem "capybara", "~> 3.1"
  gem "guard-rspec", "~> 4.7", require: false
  gem "pg", "~> 1.2"
  gem "rspec-rails", "~> 6.0"
end

group :tools do
  gem "amazing_print", "~> 1.4"
  gem "debug", "~> 1.8"
end
