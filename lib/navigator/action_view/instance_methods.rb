module Navigator
  module ActionView
    def self.included base
      base.send :include, InstanceMethods
    end

    module InstanceMethods
      def navigation tag = "ul", attributes = {}, activator = Navigator::TagActivator.new, &block
        raw Menu.new(self, tag, attributes, activator, &block).render
      end
    end
  end
end
