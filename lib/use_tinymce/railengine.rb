module UseTinymce
  class Engine < Rails::Engine
    if Rails.version =~ RAILS_3_VERSIONS || Rails.version =~ RAILS_4_VERSIONS
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
end