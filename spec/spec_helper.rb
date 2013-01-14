require "bundler/setup"
require "action_view"
require "navigator"
require "navigator/action_view/instance_methods"

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end
