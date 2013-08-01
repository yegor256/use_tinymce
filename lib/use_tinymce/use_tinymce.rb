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
      if Rails.version =~ /^3.[012]/ || Rails.version =~ /^4.[0]/
        def use_tinymce_link
          if defined?(params) && use_tinymce?(params[:action])
            ret = ''
            [['jscripts', 'tiny_mce', 'tiny_mce'], ['jscripts', 'tiny_mce', 'jquery.tinymce.js'], ['js', 'tinymce', 'jquery.tinymce.min.js']].each do |ar|
              path_ar = [Rails.root, 'public', 'javascripts', 'tinymce'] + ar
              if File.exists?( File.join(path_ar))
                ret = javascript_include_tag('/javascripts/tinymce/' + ar.join('/'), '/javascripts/use_tinymce_init')
              end
            end
            # jq_path = File.join(Rails.root, 'public', 'javascripts', 'tinymce', 'jscripts', 'tiny_mce', 'jquery.tinymce.js')
            # if File.exists? jq_path
            #   javascript_include_tag( '/javascripts/tinymce/jscripts/tiny_mce/jquery.tinymce.js', '/javascripts/use_tinymce_init' )
            # else
            #   javascript_include_tag( '/javascripts/tinymce/jscripts/tiny_mce/tiny_mce', '/javascripts/use_tinymce_init' )
            # end
            puts ret
            ret
          end
        end
      else
        raise RuntimeError.new("use_tinymce has not been tested for this version of Rails: #{Rails.version}")
      end
    end
  end
end