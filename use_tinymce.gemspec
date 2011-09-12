# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
tinymce_version = Dir.new('./assets/').map { |x| $1 if x =~ /tinymce_(.*).zip/ }.select {|x| x }.max

Gem::Specification.new do |s|
  s.name = "use_tinymce"
  s.author = "Mike Howard"
  s.email = "mike@clove.com"
  s.homepage = "http://github.com/mikehoward/use_tinymce"
  s.summary = "UseTinymce - Yet Another tinyMCE integrations gem for Rails 3"
  s.description = s.summary + "\nContains tinymce version #{tinymce_version}"
  s.files = Dir["{lib,test}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.markdown"] \
    + ["assets/use_tinymce_init_simple.js", "assets/use_tinymce_init_advanced.js", "assets/use_tinymce_init_jquery.js"] \
    + Dir['assets/tinymce*/**/*']
  s.version = "0.0.9"
end
