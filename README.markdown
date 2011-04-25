UseTinymce
==========

**UseTinymce** is yet another (as if we needed another) hack for including
tinyMCE in a Rails 3 app.

It differs from the others that I looked at on rubygems in that:

1. It works with Rails 3.0 [only one of the ones I tried actually did]
2. It's minimal. It does not provide any juicy Rails style configuration for
tinyMCE. You just use the config stuff which comes with tinyMCE - in javascript.

What's Provided
================

Three methods:

`use_tinymce *actions` - which is added to ApplicationController as a Class Method.

`*actions` is 0 or more method names or the distinguished symbol `:all`. You put
this someplace in your controller if you want any of your controller actions
to render a page which uses tinyMCE

`use_tinymce_link` - renders either an empty string or the links required to pull
in tinyMCE and `use_tinymce_init.js`. It makes it's decision by looking at the
value of `params[:action]`

If you want or need finer control, use `use_tinymce?` and write your own conditional.

`use_tinymce? action` - is a helper method you add to the cruft which creates
the `head` element of your page. It returns `true` if `action` was set by a previous
call to `use_tinymce` [or if you included `use_tinymce :all` in your controller]

Two rake tasks:

Both copy the contents of the `assets/tinymce` directory to your rails
`public/javascripts` directory. The both also copy a TinyMCE initialization
script to `public/javascripts/use_tinymce_init.js`

This initialization scripts are copied literally from the TinyMCE website
["For Dummies" page](http://tinymce.moxiecode.com/wiki.php/%22For_Dummies%22) 
(that is: http://tinymce.moxiecode.com/wiki.php/%22For_Dummies%22)

`rake use_tinymce:install_advanced` copies `assets/use_tinymce_ini_advanced.js` -
which provides all the full blown features.

`rake use_tinymce:install_simple` copies `assets/use_tinymce_ini_simple.js` -
copies the bare bones version.
