module UseTinymce
  module Base
    def use_tinymce?(action = nil)
      @use_tinymce = self.class.instance_variable_get("@use_tinymce")
      return false unless @use_tinymce
      return true if @use_tinymce.include? :all
      return @use_tinymce.include?(action) unless action.nil?
      return @use_tinymce.include?(params[:action]) if defined? params
      false
    end

    def self.included(mod)
      mod.instance_variable_set("@use_tinymce", nil)

      def mod.use_tinymce(*actions)
        @use_tinymce = actions.map { |x| x.to_sym  }
      end

      begin
        mod.send(:helper_method, :use_tinymce?)
      rescue Exception => e
      end
    end
  end
  
  if defined? Rails
    module Link
      def use_tinymce_link
        javascript_include_tag 'tinymce/jscripts/tiny_mce/tiny_mce', 'use_tinymce_init' if use_tinymce?
      end
    end
  end
end