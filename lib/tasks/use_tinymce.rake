require 'fileutils'

# make sure we are in the right versino of Rails
unless defined?(Rails)
  puts "This rake task only runs on Rails"
  exit
end
unless Rails.version =~ /^3.[012]/ || Rails.version =~ /^4.[0]/
  puts "use_tinymce Error: Don't know how to install on Rails Version #{Rails.version}"

  exit
end

module UseTinyMCE
  module RakeSupport
    # gem paths - used to source for installation
    USE_TINYMCE_ROOT = File.expand_path('../../../', __FILE__)
    ASSETS_ROOT = File.join(USE_TINYMCE_ROOT, 'assets')
  
    # target paths and customizations
    # MSH - asset pipeline gets in way, so put it in public/javascripts
    # JAVASCRIPT_ROOT = File.join(Rails.root, 'app', 'assets', 'javascripts')
    JAVASCRIPT_ROOT = File.join(Rails.root, 'public', 'javascripts')
    # set the TinyMCE selection mode: this controls which textarea elements use TinyMCE
    #  mode: specific_textareas is essentially the same as mode:textareas
    #  editor_selector: foo defines a class which MUST be present in a textarea element IF
    #   (1) editor_selector is defined & (2) you want it to have TinyMCE
    #  editor_deselector: foo defines a CLASS which must be present to keep a textarea from
    #   using TinyMCE. Note: Both editor_deselector must be defined AND the class must be present.
    # so - the settings below include TinyMCE in textareas By Default and Allow Deselecting
    # Use this if you are both masochistic and want love to positively select which textareas
    # use TinyMCE. This code 
    # MODE_STRING = [ 'mode: "specific_textareas"', '        editor_selector: "tinymce"',
    #                 '        editor_deselector: "no-tinymce"' ].join(",\n")
    MODE_STRING = [ 'mode: "specific_textareas"', '        editor_deselector: "no-tinymce"' ].join(",\n")
    # This MODE_STRING will configure to NOT USE TinyMCE in textareas unless the 'editor_selector'
    #  class is present.
    # MODE_STRING = [ 'mode: "specific_textareas"', '        editor_selector: "tinymce"' ].join(",\n")
    # JQUERY_SELECTOR = '"textarea.tinymce"'
    JQUERY_SELECTOR = '"textarea"'

    def self.copy_init_script(source)
      source_path = File.join(ASSETS_ROOT, source)
      source_text = File.new(source_path).read.sub(/\{mode_string\}/, MODE_STRING).sub(/\{jquery_selector\}/, JQUERY_SELECTOR)

      dest_path = File.join(JAVASCRIPT_ROOT, 'use_tinymce_init.js')
      mkdir_tree(JAVASCRIPT_ROOT)
      dest_file = File.new(dest_path, "w")
      dest_file.write(source_text)
      dest_file.close
    end

    # returns true if all directories from 'base' on up exist or can be created; else false
    def self.mkdir_tree(base)
      return File.directory?(base) if File.exists? base
      Dir.mkdir(base) if mkdir_tree File.dirname(base)
      return File.directory? base
    end

    def self.rmdir_tree(root)
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
  end
end

namespace :use_tinymce do
  desc "uninstall use_tinymce javascript code"
  task :uninstall do
    init_file_path = File.join(UseTinyMCE::RakeSupport::JAVASCRIPT_ROOT, 'use_tinymce_init.js')
    File.delete(init_file_path) if File.exists? init_file_path
    
    tinymce_root_path = File.join(UseTinyMCE::RakeSupport::JAVASCRIPT_ROOT, 'tinymce')
    UseTinyMCE::RakeSupport::rmdir_tree(tinymce_root_path) if File.exists? tinymce_root_path
  end

  case Rails.version
  when /^3.0/
    # common task - this undescribed task installs the non-jquery version of TinyMCE, but not the initialization script
    task :install_tinymce_advanced => :uninstall do
      raise Exception.new("Cannot install: #{UseTinyMCE::RakeSupport::JAVASCRIPT_ROOT} does not exist") unless UseTinyMCE::RakeSupport.mkdir_tree UseTinyMCE::RakeSupport::JAVASCRIPT_ROOT
      FileUtils.cp_r File.join(UseTinyMCE::RakeSupport::ASSETS_ROOT, 'tinymce_no_jquery', 'tinymce'), UseTinyMCE::RakeSupport::JAVASCRIPT_ROOT
    end
    # common task - this undescribed task installs the jquery version of TinyMCE, but not the initialization script
    task :install_tinymce_jquery => :uninstall do
      raise Exception.new("Cannot install: #{UseTinyMCE::RakeSupport::JAVASCRIPT_ROOT} does not exist") unless UseTinyMCE::RakeSupport.mkdir_tree UseTinyMCE::RakeSupport::JAVASCRIPT_ROOT
      FileUtils.cp_r File.join(UseTinyMCE::RakeSupport::ASSETS_ROOT, 'tinymce_jquery', 'tinymce'), UseTinyMCE::RakeSupport::JAVASCRIPT_ROOT
    end

    desc "Install tinymce with 'simple' initialization"
    task :install_simple => :install_tinymce_advanced do
      UseTinyMCE::RakeSupport::copy_init_script('use_tinymce_init_simple.js')
    end

    desc "Install tinymce with 'advanced' initialization"
    task :install_advanced => :install_tinymce_advanced do
      UseTinyMCE::RakeSupport::copy_init_script('use_tinymce_init_advanced.js')
    end

    desc "Install tinymce jquery plugin with 'advanced' initialization"
    task :install_jquery => :install_tinymce_jquery do
      UseTinyMCE::RakeSupport::copy_init_script('use_tinymce_init_jquery.js')
    end
  when /^3\.[12]/
    desc "Install tinymce jquery plugin with 'advanced' initialization"
    task :install => :uninstall do
      raise Exception.new("Cannot install: #{UseTinyMCE::RakeSupport::JAVASCRIPT_ROOT} does not exist") unless UseTinyMCE::RakeSupport.mkdir_tree UseTinyMCE::RakeSupport::JAVASCRIPT_ROOT
      FileUtils.cp_r File.join(UseTinyMCE::RakeSupport::ASSETS_ROOT, 'tinymce_jquery', 'tinymce'), UseTinyMCE::RakeSupport::JAVASCRIPT_ROOT
      UseTinyMCE::RakeSupport::copy_init_script('use_tinymce_init_jquery.js')
    end
  when /^4\.[0]/
    desc "Install tinymce jquery plugin with 'advanced' initialization"
    task :install => :uninstall do
      raise Exception.new("Cannot install: #{UseTinyMCE::RakeSupport::JAVASCRIPT_ROOT} does not exist") unless UseTinyMCE::RakeSupport.mkdir_tree UseTinyMCE::RakeSupport::JAVASCRIPT_ROOT
      FileUtils.cp_r File.join(UseTinyMCE::RakeSupport::ASSETS_ROOT, 'tinymce_jquery_4_0_2', 'tinymce'), UseTinyMCE::RakeSupport::JAVASCRIPT_ROOT
      UseTinyMCE::RakeSupport::copy_init_script('use_tinymce_init_jquery_4_0_2.js')
    end
    # desc "Remove tinymce jquery plugin and re-install it - WARNING: Destroys your customizations"
    # task :reinstall => :uninstall do |tsk|
    #   Rake::Task[]
    #   require 'pry'; pry binding
    # end
  else
    puts "use_tinymce error: Don't know how to install in Rails #{Rails.version}"
    exit 1
  end
end
