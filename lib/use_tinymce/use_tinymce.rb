module UseTinymce
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
      mod.send(:helper_method, :use_tinymce?, :use_tinymce_link)
    rescue Exception => e
    end
  end
end
