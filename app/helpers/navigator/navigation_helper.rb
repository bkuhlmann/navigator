# frozen_string_literal: true

module Navigator
  # Navigation helper methods for the view layer.
  module NavigationHelper
    def navigation(tag = "ul", attributes: {}, activator: navigation_activator, &)
      Navigator::Menu.new(self, tag:, attributes:, activator:, &)
                     .render
                     .then { |html| raw html }
    end

    module_function

    def current_path = request.env["PATH_INFO"]

    def navigation_activator = Navigator::TagActivator.new(search_value: current_path)
  end
end
