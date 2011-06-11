<?php
$files = array('foo', 'bar', 'baz');
$buffer = '';
$buffer .= 'tinymce.each("'
    . implode(',', $files)
    . '".split(","),function(f){tinymce.ScriptLoader.markDone(tinyMCE.baseURL+"/"+f+".js");});';

print $buffer . "\n";