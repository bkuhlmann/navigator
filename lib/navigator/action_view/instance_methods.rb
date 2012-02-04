module Navigator
  module ActionView
	  def self.included base
	    base.send :include, InstanceMethods
	  end

    module InstanceMethods
      # Renders a navigation menu.
      # ==== Parameters
      # * +tag+ - Optional. The menu tag. Default: "ul"
      # * +attributes+ - Optional. The menu tag attributes. Default: {}
      # * +block+ - Optional. The code block.
      def render_navigation tag = "ul", attributes = {}, &block
        raw Menu.new(self, tag, attributes, &block).render
      end
    end
  end
end
