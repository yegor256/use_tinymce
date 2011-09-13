require 'rake'

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

desc "build gem"
task :gem do
  system "gem build #{gem_name}.gemspec"
  if 'mike.local' == IO.popen('hostname').read.chomp
    system "cp #{gem_name}-#{gem_version}.gem ~/Rails/GemCache/gems/"
    system "(cd ~/Rails/GemCache ; gem generate_index -d . )"
  end
end

desc "push to rubygems"
task :gem_push => :gem do
  system "gem push #{gem_name}-#{gem_version}.gem"
end
