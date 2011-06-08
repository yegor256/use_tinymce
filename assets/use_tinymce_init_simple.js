// This is copied directly from http://tinymce.moxiecode.com/wiki.php/%22For_Dummies%22
tinyMCE.init({
        mode : "textareas",                // Rails 3.0
        mode: "specific_textareas",       // Rails 3.1
        editor_selector: "tinymce",          // Rails 3.1
        theme : "simple"    //(n.b. no trailing comma, this will be critical as you experiment later)
});
