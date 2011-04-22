require 'rake'

# snarf gemspec and set version
x = eval File.new('use_tinymce.gemspec').read
use_tinymce_version = x.version.to_s

task :default => :test

desc "Run ManageMeta unit tests"
task :test do
  require './test/use_tinymce_test'
end

desc "run rdoc to create doc"
task :doc do
  system 'rdoc'
end

desc "build gem"
task :gem do
  system 'gem build use_tinymce.gemspec'
end

desc "commit changes"
task :commit do
  system 'git add .'
  system 'git commit -m "checkin"'
end

desc "commit changes and tag as #{use_tinymce_version}"
task :tag => :commit do
  system "git tag #{use_tinymce_version}"
end

desc "distribute to github and rubygems"
task :distribute => [:tag, :gem] do
  system "gem push use_tinymce-#{use_tinymce_version}.gem"
  system "git push use_tinymce"
end