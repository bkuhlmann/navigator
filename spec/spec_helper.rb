require "bundler/setup"
require "active_support/core_ext"
require "action_view"
require "navigator"
require "navigator/action_view/instance_methods"
require "pry"
require "pry-remote"
require "pry-rescue"
require "coveralls"

case Gem.ruby_engine
  when "ruby"
    require "pry-byebug"
    require "pry-stack_explorer"
  when "jruby"
    require "pry-nav"
  when "rbx"
    require "pry-nav"
    require "pry-stack_explorer"
end

Coveralls.wear!

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run focus: true

  config.before(:all) { GC.disable }
  config.after(:all) { GC.enable }
end
