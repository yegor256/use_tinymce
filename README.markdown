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

## Three methods:

`use_tinymce(*actions)` - which is added to ApplicationController as a Class Method.

`*actions` is 0 or more method names or the distinguished symbol `:all`. You put
this someplace in your controller if you want any of your controller actions
to render a page which uses tinyMCE

`use_tinymce_link` - renders either an empty string or the links required to pull
in tinyMCE and `use_tinymce_init.js`. It makes it's decision by looking at the
value of `params[:action]`

If you want or need finer control, use `use_tinymce?` and write your own conditional.

`use_tinymce?(action)` - is a helper method you add to the cruft which creates
the `head` element of your page. It returns `true` if the symbol `action` was set
by a previous call to `use_tinymce` [or if you included `use_tinymce :all` in your controller]
`action` will usually come from `params[:action]`, so it's easier to use
`use_tinymce_link` which already does that.

## Two rake tasks:

Both copy the contents of the `assets/tinymce` directory to your rails
`public/javascripts` directory. They both also copy a TinyMCE initialization
script to `public/javascripts/use_tinymce_init.js`

This initialization scripts are copied literally from the TinyMCE website
["For Dummies" page](http://tinymce.moxiecode.com/wiki.php/%22For_Dummies%22) 
- that is: *http://tinymce.moxiecode.com/wiki.php/%22For_Dummies%22*

`rake use_tinymce:install_advanced` copies `assets/use_tinymce_ini_advanced.js` -
which provides all the full blown features.

`rake use_tinymce:install_simple` copies `assets/use_tinymce_ini_simple.js` -
copies the bare bones version.

Installation
===============

Add 'gem "manage_meta" to your Gemfile

Or

Add 'gem "manage_meta" :git => "git://github.com/mikehoward/use_tinymce.git"'

Then run 'bundle install'

Step by Step Configuration
==============

1. You will need to install *tinyMCE* in your /public/javascript directory.
Do that by running one of these rake tasks:
  * `rake use_tinymce:install_simple`
  * `rake use_tinymce:install_advanced`
  
  If you don't need much and aren't familiar with *tinyMCE*, then `rake use_tinymce:install_simple`
  should be fine. The *advanced* version configures *tinyMCE* with many more features. Go to
  the ["tinyMCE website for details"](http://tinymce.moxiecode.com/)
2. Add `use_tinymce args` to all the controllers for views containing **textarea** fields
in which you want to run *tinyMCE*. `args` should be:
  * `:all` - to enable *tinyMCE* for all actions
  * `:foo, :bar` - to enable *tinyMCE* only for views rendered by `foo` and `bar` actions
3. Add `<%= use_tinymce_link %>` to the `HEAD` section of you application layout - for *at least*
all pages which should use *tinyMCE*
4. (Optional) Edit `/public/javascript/use_tinymce_init.js` to customize your *tinyMCE* feature
set.

That's it.

Relocating *tinyMCE* or Something Else
==================

This gem is pretty simple, so if you want to change the location and/or names of some files,
go ahead and hack it.

There was a time when I would have added features to allow this, but not any more. It ususally
turned out to be more trouble than it was worth.

So, if you want to do it, have a blast - but please don't send me the patches.

Upgrading *tinyMCE*
==================

`use_tinymce` ships with version 3.4.2 of *tinyMCE* - which I downloaded from the Moxiecode
website. You *should* be able to upgrade your *tinyMCE* if you want by doing the exact
same thing and then unpacking the zip file in `/public/javascript`

Alternately, you can poke around your system and find the gem and unpack the zip file
into the `use_tinymce` gem's `/assets` folder, re-run the rake tasks and . . .
**WARNING** if you do this, you'll overwrite your `use_tinymce_init.js` file and lose
all your special customizations.

Alternately (2), you can send me a note and I *might* upgrade the *tinyMCE* in the gem.
Then you'd need to do a `bundle update use_tinymce`, run the rake task, re-create your
special customizations, etc.

It's probably easier to grab the code from ["Moxiecode"](http://tinymce.moxiecode.com/download/download.php)