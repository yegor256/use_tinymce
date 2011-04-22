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

Two methods:

`use_tinymce *actions` - which is added to ApplicationController as a Class Method.

`*actions` is 0 or more method names or the distinguished symbol `:all`. You put
this someplace in your controller if you want any of your controller actions
to render a page which uses tinyMCE

`use_tinymce? action` - which is a helper method you add to the cruft which creates
the `head` element of your page. It returns `true` if `action` was set by a previous
call to `use_tinymce` [or if you included `use_tinymce :all` in your controller]

One rake task:

`rake use_tinymce` copies the 