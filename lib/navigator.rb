# Dependencies
require File.join File.dirname(__FILE__), "navigator", "version.rb"
require File.join File.dirname(__FILE__), "navigator", "active_record", "class_methods.rb"
require File.join File.dirname(__FILE__), "navigator", "active_record", "instance_methods.rb"
require File.join File.dirname(__FILE__), "navigator", "action_view", "instance_methods.rb"
require File.join File.dirname(__FILE__), "navigator", "action_controller", "class_methods.rb"
require File.join File.dirname(__FILE__), "navigator", "action_controller", "instance_methods.rb"

# Rails Enhancements
if defined? Rails
  # Model
  if defined? ActiveRecord
    ActiveRecord::Base.send :include, Navigator::ActiveRecord
  end

  # View
  if defined? ActionView
    ActionView::Base.send :include, Navigator::ActionView
  end
 
  # Controller
  if defined? ActionController
    ActionController::Base.send :include, Navigator::ActionController
  end
end
