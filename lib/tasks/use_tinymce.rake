require 'fileutils'
# paths
USE_TINYMCE_ROOT = File.expand_path('../../../', __FILE__)
ASSETS_ROOT = File.join(USE_TINYMCE_ROOT, 'assets')
RAILS_REGX_TAG = Regexp.new('//\s*Rails')
case
when Rails.version =~ /^3.0/ then
  JAVASCRIPT_ROOT = File.join(Rails.root, 'public', 'javascripts')
  RAILS_REGX = Regexp.new('//\s+Rails 3.0')
when Rails.version =~ /^3.1/ then
  JAVASCRIPT_ROOT = File.join(Rails.root, 'app', 'assets', 'javascripts')
  RAILS_REGX = Regexp.new('//\s+Rails 3.1')
else
  puts "Don't know how to install on Rails Version #{Rails.version}"
  exit
end
# puts "USE_TINYMCE_ROOT: #{USE_TINYMCE_ROOT}"
# puts "ASSETS_ROOT: #{ASSETS_ROOT}"
# puts "JAVASCRIPT_ROOT: #{JAVASCRIPT_ROOT}"

def copy_init_script(source)
  source_path = File.join(ASSETS_ROOT, source)
  source_text = File.new(source_path).readlines

  dest_path = File.join(JAVASCRIPT_ROOT, 'use_tinymce_init.js')
  dest_file = File.new(dest_path, "w")

  source_text.each do |l|
    if RAILS_REGX_TAG.match(l)
      dest_file.write(l) if RAILS_REGX.match(l)
    else
      dest_file.write(l)
    end
  end
  dest_file.close
end

def rmdir_tree(root)
  Dir.entries(root).each do |fname|
    if fname[0] == '.'
      next
    else
      path = File.join(root, fname)
      if File.directory?(path)
        rmdir_tree(path)
      elsif File.file?(path)
        File.delete(path)
      end
    end
  end
  Dir.rmdir(root)
end

namespace :use_tinymce do
  task :pre_install do
    init_file_path = File.join(JAVASCRIPT_ROOT, 'use_tinymce_init.js')
    File.delete(init_file_path) if File.exists? init_file_path
    
    tinymce_root_path = File.join(JAVASCRIPT_ROOT, 'tinymce')
    rmdir_tree(tinymce_root_path) if File.exists? tinymce_root_path
  end
  task :install_tinymce_advanced => :pre_install do
    FileUtils.cp_r File.join(ASSETS_ROOT, 'tinymce_no_jquery', 'tinymce'), JAVASCRIPT_ROOT
  end
  task :install_tinymce_jquery => :pre_install do
    FileUtils.cp_r File.join(ASSETS_ROOT, 'tinymce_jquery', 'tinymce'), JAVASCRIPT_ROOT
  end

  desc "Install tinymce with 'simple' initialization"
  task :install_simple => :install_tinymce_advanced do
    copy_init_script('use_tinymce_init_simple.js')
    # FileUtils.cp File.join(ASSETS_ROOT, 'use_tinymce_init_simple.js'), File.join(JAVASCRIPT_ROOT, 'use_tinymce_init.js')
  end

  desc "Install tinymce with 'advanced' initialization"
  task :install_advanced => :install_tinymce_advanced do
    copy_init_script('use_tinymce_init_advanced.js')
    # FileUtils.cp File.join(ASSETS_ROOT, 'use_tinymce_init_advanced.js'), File.join(JAVASCRIPT_ROOT, 'use_tinymce_init.js')
  end

  desc "Install tinymce jquery plugin with 'advanced' initialization"
  task :install_jquery => :install_tinymce_jquery do
    copy_init_script('use_tinymce_init_jquery.js')
    # FileUtils.cp File.join(ASSETS_ROOT, 'use_tinymce_init_jquery.js'), File.join(JAVASCRIPT_ROOT, 'use_tinymce_init.js')
  end
end
