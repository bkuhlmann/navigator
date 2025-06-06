# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "navigator"
  spec.version = "11.2.1"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://alchemists.io/projects/navigator"
  spec.summary = "A Rails domain specific language for menu navigation."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/navigator/issues",
    "changelog_uri" => "https://alchemists.io/projects/navigator/versions",
    "homepage_uri" => "https://alchemists.io/projects/navigator",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "Navigator",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/navigator"
  }

  spec.post_install_message = <<~MESSAGE
    DEPRECATION: The Navigator gem is deprecated and will be fully destroyed on 2026-06-15.
  MESSAGE

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.4"
  spec.add_dependency "rails", "~> 8.0"
  spec.add_dependency "refinements", "~> 13.0"

  spec.files = Dir["*.gemspec", "app/**/*", "lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
end
