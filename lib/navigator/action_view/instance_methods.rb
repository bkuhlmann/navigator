module Navigator
  module ActionView
    def self.included base
      base.send :include, InstanceMethods
    end

    module InstanceMethods
      def navigation tag = "ul", attributes = {}, activator = navigation_activator, &block
        raw Menu.new(self, tag, attributes, activator, &block).render
      end

      module_function

      def current_path
        request.env["PATH_INFO"]
      end

      def navigation_activator
        Navigator::TagActivator.new search_value: current_path
      end
    end
  end
end
