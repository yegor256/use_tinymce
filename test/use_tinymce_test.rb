$LOAD_PATH << File.expand_path("../../lib",  __FILE__)
require 'test/unit'
require 'use_tinymce'

Rails = true
puts Object.constants.grep /^Ra/

class UseTinymceTest < Test::Unit::TestCase
  
  @@helper_args = nil
  # add refute methods for ruby 1.8.7
  if !self.instance_methods.include? :refute_respond_to
    def refute_respond_to(obj, func, msg = nil)
      assert ! obj.respond_to?( func, msg )
    end
    
    def refute(expr, msg = nil)
      assert ! expr, msg
    end
  end

  # add fake helper_method method if required for testing
  unless self.respond_to? :helper_method
    def self.helper_method *args
      @@helper_args = args
    end
  end
  
  def setup
    self.class.instance_variable_set("@use_tinymce", nil)
    # params = nil
  end

  include UseTinymce

  def test_methods_defined
    assert respond_to?(:use_tinymce?), "#{self} has public method :use_tinymce?"
    assert respond_to?(:use_tinymce_link), "#{self} has public method :use_tinymce_link" if defined? Rails
    assert self.class.respond_to?(:use_tinymce), "#{self.class} has method :use_tinymce"
  end

  def test_class_instance_variable_initialized
    assert self.class.instance_variable_get("@use_tinymce").nil?, "#{self.class}#@use_tinymce is nil"
  end

  def test_use_tinymce_defaults_to_false
    refute use_tinymce?, "use_tinymce? defaults to false"
  end

  def test_use_tinymce_all
    refute use_tinymce?, "use_tinymce default is false"
    self.class.send(:use_tinymce, :all)
    assert use_tinymce?, "use_tinymce :all causes use_tinymce? to be true"
  end
  
  def test_use_tinymce_sets_values
    refute use_tinymce?, "use_tinymce default is false"
    self.class.send(:use_tinymce, :edit, :new)
    assert self.class.instance_variable_get("@use_tinymce") == [:edit, :new], "use_tinymce :edit, :new works"
  end
  
  def test_use_tinymce_checks_params
    refute use_tinymce?, "use_tinymce default is false"
    self.class.send(:use_tinymce, :edit, :new)
    assert use_tinymce?(:edit), "use_tinymce? true when action => :edit"
    assert use_tinymce?(:new), "use_tinymce? true when action => :new"
    refute use_tinymce?(:index), "use_tinymce? false when action => :index"
  end

  # test 'helper method called'
  def test_helper_method_called
   refute @@helper_args.nil?, "helper_method called with at least one argument"
  end
end