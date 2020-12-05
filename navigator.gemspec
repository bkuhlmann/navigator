# frozen_string_literal: true

require_relative "lib/navigator/identity"

Gem::Specification.new do |spec|
  spec.name = Navigator::Identity::NAME
  spec.version = Navigator::Identity::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://www.alchemists.io/projects/navigator"
  spec.summary = "Enhances Rails with a DSL for menu navigation."
  spec.license = "Apache-2.0"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/navigator/issues",
    "changelog_uri" => "https://www.alchemists.io/projects/navigator/changes.html",
    "documentation_uri" => "https://www.alchemists.io/projects/navigator",
    "source_code_uri" => "https://github.com/bkuhlmann/navigator"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 2.7"
  spec.add_dependency "rails", "~> 6.0"
  spec.add_development_dependency "amazing_print", "~> 1.2"
  spec.add_development_dependency "bundler-audit", "~> 0.7"
  spec.add_development_dependency "bundler-leak", "~> 0.2"
  spec.add_development_dependency "capybara", "~> 3.1"
  spec.add_development_dependency "gemsmith", "~> 14.8"
  spec.add_development_dependency "git-lint", "~> 1.3"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
  spec.add_development_dependency "pg", "~> 1.2"
  spec.add_development_dependency "pry", "~> 0.13"
  spec.add_development_dependency "pry-byebug", "~> 3.9"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "reek", "~> 6.0"
  spec.add_development_dependency "refinements", "~> 7.16"
  spec.add_development_dependency "rspec-rails", "~> 4.0"
  spec.add_development_dependency "rubocop", "~> 1.3"
  spec.add_development_dependency "rubocop-performance", "~> 1.8"
  spec.add_development_dependency "rubocop-rake", "~> 0.5"
  spec.add_development_dependency "rubocop-rspec", "~> 2.0"
  spec.add_development_dependency "simplecov", "~> 0.19"

  spec.files            = Dir["app/**/*", "lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.require_paths    = ["lib"]
end
