require "bundler/setup"
require "active_support/core_ext"
require "action_view"
require "navigator"
require "navigator/action_view/instance_methods"
require "pry"

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run focus: true
end
