files = ['foo', 'bar', 'baz']
j_code = 'tinymce.each("' + files.join(',') + '".split(","),function(f){tinymce.ScriptLoader.markDone(tinyMCE.baseURL+"/"+f+".js");});';

puts j_code