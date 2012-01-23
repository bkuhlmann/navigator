module Navigator
  module ActiveRecord
    def self.included base
      base.extend ClassMethods
    end
    
    module ClassMethods
      def acts_as_navigator options = {}
        self.send :include, InstanceMethods
        
        # Default Options
        class_inheritable_reader :navigator_options
        write_inheritable_attribute :navigator_options, options
      end
    end
  end
end
