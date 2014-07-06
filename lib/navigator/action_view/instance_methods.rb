module Navigator
  module ActionView
    def self.included base
      base.send :include, InstanceMethods
    end

    module InstanceMethods
      def navigation tag = "ul", attributes = {}, &block
        raw Menu.new(self, tag, attributes, &block).render
      end
    end
  end
end
