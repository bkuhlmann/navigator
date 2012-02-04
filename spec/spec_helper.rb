require "bundler/setup"
require "action_view"
require "navigator"
require "navigator/action_view/instance_methods"

RSpec.configure do |config|
  config.before :suite do
    include ActionView::Helpers
    include Navigator::ActionView::InstanceMethods
    ERBHandler = ActionView::Template::Handlers::ERB.new
  end  
end
