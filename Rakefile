require 'rake'

gem_name = 'use_tinymce'

# snarf gemspec and set version
gem_spec = eval File.new("#{gem_name}.gemspec").read
gem_version = gem_spec.version.to_s
tinymce_version = Dir.new('./assets/').map { |x| $1 if x =~ /tinymce_(.*).zip/ }.select {|x| x }.max
gem_zip = "#{gem_name}_#{gem_version}.zip"
gem_tgz = "#{gem_name}_#{gem_version}.tgz"

task :default => :test

desc "Run ManageMeta unit tests"
task :test do
  require "./test/#{gem_name}_base_test"
end

desc "run rdoc to create doc"
task :doc do
  system 'rdoc'
end

desc "build gem"
task :gem do
  system "gem build #{gem_name}.gemspec"
end

desc "commit changes - use Env Var MSG to add comment"
task :commit do
  system 'git add .'
  system "git commit -m \"checkin version #{gem_version}: ${MSG}\""
end

desc "commit changes and tag as #{gem_version} - add Env Var MSG to add tag message"
task :tag => :commit do
  tag_message = "version #{gem_version}"
  tag_message += ENV['MSG'] if ENV.keys.include? 'MSG'
  system "git tag #{gem_version} -m '#{tag_message}'"
end

desc "push to github"
task :git_push  do
  system 'git push'
end

desc "push to rubygems"
task :gem_push => :gem do
  system "gem push #{gem_name}-#{gem_version}.gem"
end
