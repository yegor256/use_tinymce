require 'rake'
require "./lib/use_tinymce/version.rb"

gem_name = 'use_tinymce'

# snarf gemspec and set version
gem_spec = eval File.new("#{gem_name}.gemspec").read
gem_version = gem_spec.version.to_s
tinymce_version = Dir.new('./assets/').map { |x| $1 if x =~ /tinymce_(.*).zip/ }.select {|x| x }.max
gem_zip = "#{gem_name}_#{gem_version}.zip"
gem_tgz = "#{gem_name}_#{gem_version}.tgz"

task :default => :test

desc "Run use_tinymce unit tests"
task :test do
  require "./test/test_#{gem_name}_base"
end

desc "create README.markdown from README.markdown.in by replacing @@FOO@@ with FOO Value"
file "README.markdown" => ["README.markdown.in"] do
  system "sed -e 's/@@VERSION@@/#{UseTinymce::VERSION}/g' <'README.markdown.in' >'README.markdown'"
end

desc "build gem"
task :gem => ["README.markdown"] do
  system "gem build #{gem_name}.gemspec"
  if 'mike.local' == IO.popen('hostname').read.chomp
    system "cp #{gem_name}-#{gem_version}.gem ~/Rails/GemCache/gems/"
    system "(cd ~/Rails/GemCache ; gem generate_index -d . )"
  end
end

desc "push to rubygems"
task :gem_push => [:gem] do
  unless UseTinymce::VERSION =~ /pre/ then
    system "gem push #{gem_name}-#{gem_version}.gem"
  else
    puts "Cannot push a pre version - test it you fool!!!!"
  end
end
