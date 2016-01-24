# frozen_string_literal: true

module Navigator
  # The main engine.
  class Engine < ::Rails::Engine
    isolate_namespace Navigator

    initializer "navigator.action_controller" do
      ActiveSupport.on_load :action_controller do
        helper Navigator::Engine.helpers
      end
    end
  end
end
