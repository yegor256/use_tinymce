require 'fileutils'
# paths
USE_TINYMCE_ROOT = File.expand_path('../../../', __FILE__)
ASSETS_ROOT = File.join(USE_TINYMCE_ROOT, 'assets')
case
when Rails.version =~ /^3.0/ then JAVASCRIPT_ROOT = File.join(Rails.root, 'public', 'javascripts')
when Rails.version =~ /^3.1/ then JAVASCRIPT_ROOT = File.join(Rails.root, 'app', 'assets', 'javascripts')
else
  puts "Don't know how to install on Rails Version #{Rails.version}"
  exit
end
# puts "USE_TINYMCE_ROOT: #{USE_TINYMCE_ROOT}"
# puts "ASSETS_ROOT: #{ASSETS_ROOT}"
# puts "JAVASCRIPT_ROOT: #{JAVASCRIPT_ROOT}"

namespace :use_tinymce do
  task :install_tinymce do
    FileUtils.cp_r File.join(ASSETS_ROOT, 'tinymce'), JAVASCRIPT_ROOT
  end
  task :install_tinymce do
    FileUtils.cp_r File.join(ASSETS_ROOT, 'tinymce'), JAVASCRIPT_ROOT
  end

  desc "Install tinymce with 'simple' initialization"
  task :install_simple => :install_tinymce do
    FileUtils.cp File.join(ASSETS_ROOT, 'use_tinymce_init_simple.js'), File.join(JAVASCRIPT_ROOT, 'use_tinymce_init.js')
  end

  desc "Install tinymce with 'advanced' initialization"
  task :install_vanilla => :install_tinymce do
    FileUtils.cp File.join(ASSETS_ROOT, 'use_tinymce_init_advanced.js'), File.join(JAVASCRIPT_ROOT, 'use_tinymce_init.js')
  end
  
  task :install do
    task :migrations do
      puts "There are no migrations in use_tinymce - this is a simple stub to make Rails 3.1 happy"
    end
  end
end
