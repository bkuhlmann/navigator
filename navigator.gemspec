# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "navigator/version"

Gem::Specification.new do |s|
  s.name									= "navigator"
  s.version								= Navigator::VERSION
  s.platform							= Gem::Platform::RUBY
  s.author								= "Brooke Kuhlmann"
  s.email									= "brooke@redalchemist.com"
  s.homepage							= "http://www.redalchemist.com"
  s.summary								= "Enhances Rails with a DSL for menu navigation."
  s.description						= "Enhances Rails with a DSL for menu navigation complete with sub-menus, nested tags, HTML attributes, etc."
	s.license								= "MIT"

	s.required_ruby_version = "~> 1.9.0"
	s.add_dependency "rails", "~> 3.0"
	s.add_development_dependency "rake"
  s.add_development_dependency "pry"
  s.add_development_dependency "pry-nav"
  s.add_development_dependency "pry-stack_explorer"
  s.add_development_dependency "pry-vterm_aliases"
	s.add_development_dependency "rspec-rails"
  s.add_development_dependency("rb-fsevent") if RUBY_PLATFORM =~ /darwin/i
  s.add_development_dependency "guard-rspec"

  s.files            = Dir["lib/**/*"]
  s.extra_rdoc_files = Dir["README*", "CHANGELOG*", "LICENSE*"]
  s.require_paths    = ["lib"]
end
