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

  spec.required_ruby_version = "~> 3.0"
  spec.add_dependency "rails", "~> 6.0"
  spec.add_dependency "refinements", "~> 7.18"

  spec.files            = Dir["app/**/*", "lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.require_paths    = ["lib"]
end
