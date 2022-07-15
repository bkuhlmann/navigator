# frozen_string_literal: true

ruby File.read(".ruby-version").strip

source "https://rubygems.org"

gemspec

group :code_quality do
  gem "caliber", "~> 0.11"
  gem "git-lint", "~> 4.0"
  gem "reek", "~> 6.1"
  gem "simplecov", "~> 0.21"
end

group :development do
  gem "rake", "~> 13.0"
end

group :test do
  gem "capybara", "~> 3.1"
  gem "guard-rspec", "~> 4.7", require: false
  gem "pg", "~> 1.2"
  gem "rspec-rails", "~> 5.0"
end

group :tools do
  gem "amazing_print", "~> 1.4"
  gem "debug", "~> 1.6"
end
