vim-css3-syntax
===============

Add CSS3 syntax support to [Vim][1]'s built-in `syntax/css.vim`.


INSTALLATION
------------

I **strongly** recommend to install this plugin on *Vim 7.4 or higher with default runtime files*.


### Manual Installation

Download from GitHub, extract `vim-css3-syntax.tar.gz`, and copy the contents to your `~/.vim` directory.


### Installing with Git and pathogen

    $ cd ~/.vim/bundle
    $ git clone https://github.com/hail2u/vim-css3-syntax.git


NOTES
-----

### Vendor Prefixes

I do not plan to support CSS3 properties (or functions) with vendor prefixes, such as `-webkit-` or `-moz-`, etc. These are hard to maintain because they are:

  * Added frequently
  * Changed unexpectedly
  * Removed silently

These must be supported by separate syntax plugins (Vim 7.4's default CSS syntax file supports this). If you want to highlight prefixed properties or functions manually, `:highlight` and `:match` would help:

    :highlight VendorPrefix guifg=#00ffff gui=bold
    :match VendorPrefix /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/

These commands highlight vendor prefixed properties and functions instantly with cyan and bold (on gVim).


### CSS Preprocessors: [Sass][2], [LESS][3], and [Stylus][4]

`vim-css3-syntax` supports Sass's SCSS syntax only. If you want use this plugin with LESS, install [VIM-LESS][5]. Sass's indent synatx and Stylus are not supported.


HISTORY
-------

### v0.9

  * Add Compositing and Blending Level 1 features
  * Add CSS Fonts Module Level 3 features
  * Add CSS Speech Module features
  * Add Selectors Level 4 features
  * Split CSS Counter Styles Level 3 features from `css3-lists.vim`
  * Follow spec updates
  * Add missing values
  * Add notes about CSS preprocessors
  * Fix test
  * Add version checking


### v0.8

  * Add CSS Masking Level 1 features
  * Add CSS Shapes Module Level 1 features
  * Follow spec updates
  * Add missing properties
  * Some minor bug fixes


### v0.7

  * Add CSS Conditional Rules Module Level 3 features
  * Add CSS Intrinsic & Extrinsic Sizing Module Level 3 features
  * Add CSS Cascading and Inheritance Level 3 features
  * Add CSS Paged Media Module Level 3 features
  * Add CSS Custom Properties for Cascading Variables Module Level 1 features
  * Add CSS Overflow Module Level 3 features
  * Seperate CSS Text Decoration Module Level 3 features
  * Follow spec updates
  * Bundle `after/syntax/html.vim` and `after/syntax/scss.vim`
  * Some minor bug fixes


### v0.6

  * Add Test
  * Remove deprecated CSS Grid Positioning Module
  * Follow spec updates
  * Some minor bug fixes


### v0.5

  * Add CSS Regions Module Level 3 features
  * Add CSS Exclusions and Shapes Module Level 3 features
  * Add CSS Grid Layout features
  * Add CSS Box Alignment features
  * Add `gr` unit
  * Follow spec updates
  * Some minor bug fixes


### v0.4

  * Add CSS Fragmentation Module Level 3 features
  * Fix a problem on pseudo-class and pseudo-element names inside @media block
  * Fix a problem on media type and expression
  * Add CSS Values and Units Module Level 3 features
  * Follow spec updates
  * Some minor bug fixes


### v0.3

  * Add CSS3 Presentation Levels Module features
  * Add CSS3 Lists Module features
  * Add CSS3 Generated and Replaced Content Module features
  * Add CSS Template Layout Module features
  * Add CSS Image Values and Replaced Content Module Level 3 features
  * Fix a problem on class names inside @media block
  * Some minor bug fixes


### v0.2

  * Almost all CSS3 features added


### v0.1

  * Initial release


AUTHOR
------

Kyo Namegashima <kyo@hail2u.net>


LICENSE
-------

MIT: http://hail2u.mit-license.org/2011


[1]: http://www.vim.org/
[2]: http://sass-lang.com/
[3]: http://lesscss.org/
[4]: http://learnboost.github.io/stylus/
[5]: https://github.com/groenewege/vim-less
