module UseTinymce
  class Engine < Rails::Engine
    initializer "active_support.add_use_tinymce" do
      ::ActiveSupport.on_load(:action_controller) do
        include UseTinymce::Base
      end
      ::ActiveSupport.on_load(:action_view) do
        include UseTinymce::Link
      end
    end
  end
end