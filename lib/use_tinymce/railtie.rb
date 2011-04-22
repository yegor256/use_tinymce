module UseTinymce
  class Railtie < Rails::Railtie
    initializer "action_controller.add_use_tinymce" do
      ::ActiveSupport.on_load(:action_controller) do
        include UseTinymce
      end
    end
  end
end