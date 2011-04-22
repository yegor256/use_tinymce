puts "#{__FILE__}:#{__LINE__}: self: #{self}"
module UseTinymce
  puts "#{__FILE__}:#{__LINE__}: self: #{self}"
  class Railtie < Rails::Railtie
    puts "#{__FILE__}:#{__LINE__}: self: #{self}"
    initializer "action_controller.add_use_tinymce" do
      ::ActiveSupport.on_load(:action_controller) do
        puts "#{__FILE__}:#{__LINE__}: self: #{self}"
        include UseTinymce
      end
    end
  end
end