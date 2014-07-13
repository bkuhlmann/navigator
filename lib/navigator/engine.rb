module Navigator
  class Engine < ::Rails::Engine
    isolate_namespace Navigator

    initializer "navigator.action_controller" do |app|
      ActiveSupport.on_load :action_controller do
        helper Navigator::Engine.helpers
      end
    end
  end
end
