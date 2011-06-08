module UseTinymce
  module Base
    def use_tinymce?(action = nil)
      @use_tinymce = self.class.instance_variable_get("@use_tinymce")
      return false unless @use_tinymce
      return true if @use_tinymce.include? :all
      return @use_tinymce.include?(action.to_sym) unless action.nil?
      return @use_tinymce.include?(params[:action].to_sym) if defined? params
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
      case
      when Rails.version =~ /^3.0/
        def use_tinymce_link
          javascript_include_tag( 'tinymce/jscripts/tiny_mce/tiny_mce', 'use_tinymce_init' ) \
              if defined?(params) && use_tinymce?(params[:action])
        end
      when Rails.version =~ /^3.1/
        def use_tinymce_link
          # do nothing. Rails 3.1.x pulls in all the code in /app/assets/javascripts if you
          # use javascript_include_tag "application"
        end
      else
        logger.debug("use_tinymce has not been tested for this version of Rails: #{Rails.version}")
      end
    end
  end
end