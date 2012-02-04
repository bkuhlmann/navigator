require File.join File.dirname(__FILE__), "navigator", "tag.rb"
require File.join File.dirname(__FILE__), "navigator", "menu.rb"

# Rails Enhancements
if defined? Rails
  # Dependencies
  require File.join File.dirname(__FILE__), "navigator", "version.rb"
  require File.join File.dirname(__FILE__), "navigator", "action_view", "instance_methods.rb"

  # View
  if defined? ActionView
    ActionView::Base.send :include, Navigator::ActionView
  end
end
