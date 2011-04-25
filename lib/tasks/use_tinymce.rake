require 'fileutils'
# paths
USE_TINYMCE_ROOT = File.expand_path('../../../', __FILE__)
ASSETS_ROOT = File.join(USE_TINYMCE_ROOT, 'assets')
JAVASCRIPT_ROOT = File.join(Rails.root, 'public', 'javascripts')

# puts "USE_TINYMCE_ROOT: #{USE_TINYMCE_ROOT}"
# puts "ASSETS_ROOT: #{ASSETS_ROOT}"
# puts "JAVASCRIPT_ROOT: #{JAVASCRIPT_ROOT}"

namespace :use_tinymce do
  task :install_tinymce do
    FileUtils.cp_r File.join(ASSETS_ROOT, 'tinymce'), JAVASCRIPT_ROOT
  end

  desc "Install tinymce with 'simple' initialization"
  task :install_simple => :install_tinymce do
    FileUtils.cp File.join(ASSETS_ROOT, 'use_tinymce_init_simple.js'), File.join(JAVASCRIPT_ROOT, 'use_tinymce_init.js')
  end

  desc "Install tinymce with 'advanced' initialization"
  task :install_advanced => :install_tinymce do
    FileUtils.cp File.join(ASSETS_ROOT, 'use_tinymce_init_advanced.js'), File.join(JAVASCRIPT_ROOT, 'use_tinymce_init.js')
  end
end
