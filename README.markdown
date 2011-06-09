UseTinyMCE
==========

**UseTinyMCE** is yet another (as if we needed another) hack for including
TinyMCE in a Rails 3 app.

It differs from the others that I looked at on rubygems in that:

1. It works with Rails 3.0 [only one of the ones I tried actually did]
2. It's minimal. It does not provide any juicy Rails style configuration for
TinyMCE. You just use the config stuff which comes with TinyMCE - in javascript.

What's Provided
================

## Integration with a Prototype based site

This brings in the 'advanced' version of TinyMCE.

Install using `rake use_tinymce:install_advanced` to get the 'advanced' configuration
initialization file.

Or, you can install using `rake use_tinymce:install_simple` to use the 'simple' configuration.

## Integration with jQuery

This uses the TinyMCE jQuery plugin. See [jQuery Plugin](http://tinymce.moxiecode.com/wiki.php/jQuery_Plugin)
on the MoxieCode site for configuration details.

Install using `rake use_tinymce:install_jquery`, which installs an `advanced` TinyMCE
configuration file which uses jQuery selectors.

## Rails 3.0 Integration

Rails 3.0 loads javascript files one at a time, so we can control whether
TinyMCE is used with a *textarea* by controlling when it is included.

We do this invoking `use_tinymce(*actions)` in the controllers which display
pages on which we want to use TinyMCE. TinyMCE will be automatically applied
to all of the `textarea` elements of the selected pages.

This is controlled by using the view helper `use_tinymce_link` in the application layout
(or, for more complex situations, you can use the predicate `use_tinymce?(action)` and
some code you write)

### `use_tinymce(*actions)`

Which is added to ApplicationController as a Class Method.

`*actions` is 0 or more method names or the distinguished symbol `:all`. You put
this someplace in your controller if you want any of your controller actions
to render a page which uses TinyMCE

### `use_tinymce_link`

Which renders either an empty string or the links required to pull
in TinyMCE and `use_tinymce_init.js`. It makes it's decision by looking at the
value of `params[:action]`

### `use_tinymce?(action)`
Which you can use if you want or need finer control, use `use_tinymce?`
and write your own conditional.

`use_tinymce(action)` is a helper method you add to the cruft which creates
the `head` element of your page. It returns `true` if the symbol `action` was set
by a previous call to `use_tinymce` [or if you included `use_tinymce :all` in your controller]
`action` will usually come from `params[:action]`, so it's easier to use
`use_tinymce_link` which already does that.

### Step by Step Configuration

1. You will need to install *TinyMCE* in your /public/javascript directory.
Do that by running one of these rake tasks:
  * `rake use_tinymce:install_simple`
  * `rake use_tinymce:install_advanced`
  * `rake use_tinymce:install_jquery`
  
  If you don't need much and aren't familiar with *TinyMCE*, then `rake use_tinymce:install_simple`
  should be fine. The *advanced* version configures *TinyMCE* with many more features. Go to
  the ["TinyMCE website for details"](http://tinymce.moxiecode.com/)
2. Add `use_tinymce args` to all the controllers for views containing **textarea** fields
in which you want to run *TinyMCE*. `args` should be:
  * `:all` - to enable *TinyMCE* for all actions
  * `:foo, :bar` - to enable *TinyMCE* only for views rendered by `foo` and `bar` actions
3. Add `<%= use_tinymce_link %>` to the `HEAD` section of you application layout - for *at least*
all pages which should use *TinyMCE*
4. (Optional) Edit `/public/javascript/use_tinymce_init.js` to customize your *TinyMCE* feature
set.

That's it.

## Rails 3.1 Integration

Rails 3.1 adds the 'asset pipeline' by default. This uses the 'sprocket' gem
to combine javascript and css into two files as well as adding direct support
of Coffeescript and SASS.

It also mucks up TinyMCE because TinyMCE - by default - dynamically loads it's
plugins as they are needed. While the TinyMCE implementation is quite nice,
it and the asset pipeline mess each other up.

There are a lot of ways to resolve this - but I've chosen a simple, brute force
approach: I've concatenated all of the TinyMCE files together into a single,
minified file which we load in.

There are several downsides related to TinyMCE plugins:

1. I've included all the plugins that TinyMCE ships with. This makes them
all available for customization using the 'advanced' menu.
2. The file size is larger than needed in many cases. I think using the pipeline
justifies this: we only have to download once and only for the first request
from the site.
3. The file would need to be rebuilt if you want to add any plugins.

The default behavior is to compile all of the scripts into a single file which
is then uploaded. I've chosen to take the simple approach and use the method
recommended by Moxicode: add a 'tinymce' class to all `textarea` elements
you want to use TinyMCE on.

So, with Rails 3.1, you will have a single `javascript_include_tag "application"`
and will add `class="tinymce"` to all `textarea` elements in all views and partials
that you want to apply TinyMCE to.

The methods `use_tinymce`, `use_tinymce_link`, and `use_tinymce?` are not defined
and can't be used.

### Step by Step Configuration

1. You will need to install *TinyMCE* in your /public/javascript directory.
Do that by running one of these rake tasks:
  * `rake use_tinymce:install_simple`
  * `rake use_tinymce:install_advanced`
  * `rake use_tinymce:install_jquery`
2. Add the `tinymce` class to all the `textarea` elements in all views and partials
you want to apply TinyMCE to.

## Three rake tasks:

**NOTE:** Rails 3.1 automatically adds a rake task 'use_tinymce_engine:install:migrations'.
It doesn't do anything 'cause there aren't any migrations for 'use_tinymce'.
Ignore it.

Both copy the contents of the `assets/TinyMCE` directory to your rails
`public/javascripts` directory. They both also copy a TinyMCE initialization
script to `public/javascripts/use_tinymce_init.js`

This initialization scripts are copied literally from the TinyMCE website
["For Dummies" page](http://tinymce.moxiecode.com/wiki.php/%22For_Dummies%22) 
- that is: *http://tinymce.moxiecode.com/wiki.php/%22For_Dummies%22*

`rake use_tinymce:install_advanced` copies `assets/use_tinymce_init_advanced.js` -
which provides all the full blown features.

`rake use_tinymce:install_simple` copies `assets/use_tinymce_ini_simple.js` -
copies the bare bones version.

The jQuery version was copied from an example script and then slightly modified
[see the code comments].

`rake use_tinymce:install_jquery` copies `assets/use_tinymce_init_jquery.js` -
which attaches an 'advanced' TinyMCE configuration to textareas.

Relocating *TinyMCE* or Something Else
==================

This gem is pretty simple, so if you want to change the location and/or names of some files,
go ahead and hack it.

There was a time when I would have added features to allow this, but not any more. It ususally
turned out to be more trouble than it was worth.

So, if you want to do it, have a blast - but please don't send me the patches.

Upgrading *TinyMCE*
==================

`use_tinymce` ships with version 3.4.2 of *TinyMCE* - which I downloaded from the Moxiecode
website. You *should* be able to upgrade your *TinyMCE* if you want by doing the exact
same thing and then unpacking the zip file in `/public/javascript`

**WARNING:** Rails 3.1 uses sprockets which has a problem compiling non-Unicoded characters.
the advanced *TinyMCE* contains some directly encoded characters in the *spellchecker_word_separator_chars*
variable in the spellchecking plugin. I've modified the code to convert them to Unicode \U...
representations. If you upgrade *TinyMCE* and run with Rails 3.1 + you will probably have
to do the same.

Alternately, you can poke around your system and find the gem and unpack the zip file
into the `use_tinymce` gem's `/assets` folder, re-run the rake tasks and . . .
**WARNING** if you do this, you'll overwrite your `use_tinymce_init.js` file and lose
all your special customizations.

Alternately (2), you can send me a note and I *might* upgrade the *TinyMCE* in the gem.
Then you'd need to do a `bundle update use_tinymce`, run the rake task, re-create your
special customizations, etc.

It's probably easier to grab the code from ["Moxiecode"](http://tinymce.moxiecode.com/download/download.php)