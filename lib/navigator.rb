require "navigator/tag"
require "navigator/menu"

# Rails Enhancements
if defined? Rails
  # Dependencies
  require "navigator/version"
  require "navigator/action_view/instance_methods"

  # View
  if defined? ActionView
    ActionView::Base.send :include, Navigator::ActionView
  end
end
