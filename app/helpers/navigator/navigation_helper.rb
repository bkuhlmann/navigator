# frozen_string_literal: true

module Navigator
  # Navigation helper methods for the view layer.
  module NavigationHelper
    # rubocop:disable Metrics/ParameterLists
    def navigation tag = "ul", attributes: {}, activator: navigation_activator, &block
      Navigator::Menu.new(self, tag: tag, attributes: attributes, activator: activator, &block)
                     .render
                     .then { |html| raw html }
    end
    # rubocop:enable Metrics/ParameterLists

    module_function

    def current_path = request.env["PATH_INFO"]

    def navigation_activator = Navigator::TagActivator.new(search_value: current_path)
  end
end
