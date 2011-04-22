# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "use_tinymce"
  s.author = "Mike Howard"
  s.email = "mike@clove.com"
  s.homepage = "http://github.com/mikehoward/use_tinymce"
  s.summary = "UseTinymce - Yet Another tinyMCE integrations gem for Rails 3"
  s.description = s.summary
  s.files = Dir["{lib,test}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.markdown"] + ["assets/*.zip"]
  s.version = "0.0.1"
end
