require "navigator/version"
require "navigator/tag_activator"
require "navigator/tag"
require "navigator/menu"

# Rails Enhancements
if defined? Rails
  # Dependencies
  require "navigator/action_view/instance_methods"

  # View
  if defined? ActionView
    ActionView::Base.send :include, Navigator::ActionView
  end
end
