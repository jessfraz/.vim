.vim
====

My vim dot files. the `.vimrc` file is saved to [vimrc](https://github.com/jessfraz/.vim/blob/master/vimrc).

**Table of Contents**

<!-- toc -->

- [About](#about)
  * [Installing](#installing)
  * [Pathogen](#pathogen)
  * [Plugins Used](#plugins-used)
- [Contributing](#contributing)
  * [Using the `Makefile`](#using-the-makefile)

<!-- tocstop -->

## About

### Installing

Just run the following commands via terminal to get perfectly set up:

```console
$ cd ~/
$ git clone --recursive https://github.com/jessfraz/.vim.git .vim
$ ln -sf $HOME/.vim/vimrc $HOME/.vimrc
$ cd $HOME/.vim
$ git submodule update --init
```

### Pathogen
The vim dot files make use of the excellent [Pathogen](https://github.com/tpope/vim-pathogen) runtime path manager to install plugins and runtime files into their own private directiories.

Currently using version 2.4 of Pathogen

### Plugins Used

* [Dockerfile](https://github.com/docker/docker/tree/master/contrib/syntax/vim)
* [github.com/neoclide/coc.nvim](https://github.com/neoclide/coc.nvim.git)
* [github.com/ctrlpvim/ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim.git)
* [github.com/Raimondi/delimitMate](https://github.com/Raimondi/delimitMate.git)
* [github.com/vivien/vim-linux-coding-style](https://github.com/vivien/vim-linux-coding-style.git)
* [github.com/scrooloose/nerdtree](https://github.com/scrooloose/nerdtree.git)
* [github.com/Xuyuanp/nerdtree-plugin.git](https://github.com/Xuyuanp/nerdtree-git-plugin.git)
* [github.com/chr4/nginx.vim](https://github.com/chr4/nginx.vim.git)
* [github.com/rust-lang/rust.vim](https://github.com/rust-lang/rust.vim.git)
* [github.com/godlygeek/tabular](https://github.com/godlygeek/tabular.git)
* [github.com/vim-airline/vim-airline](https://github.com/vim-airline/vim-airline.git)
* [github.com/vim-airline/vim-airline-themes](https://github.com/vim-airline/vim-airline-themes.git)
* [github.com/moll/vim-bbye](https://github.com/moll/vim-bbye.git)
* [github.com/ntpeters/vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace.git)
* [github.com/ap/vim-buftabline](https://github.com/ap/vim-buftabline.git)
* [github.com/crosbymichael/vim-cfmt](https://github.com/crosbymichael/vim-cfmt)
* [github.com/altercation/vim-colors-solarized](https://github.com/altercation/vim-colors-solarized.git)
* [github.com/tpope/vim-endwise](https://github.com/tpope/vim-endwise.git)
* [github.com/tpope/vim-five.git](https://github.com/tpope/vim-fugitive.git)
* [github.com/tpope/vim.git](https://github.com/tpope/vim-git.git)
* [github.com/airblade/vimgutter.git](https://github.com/airblade/vim-gitgutter.git)
* [github.com/fatih/vim-go](https://github.com/fatih/vim-go.git)
* [github.com/fatih/vim-hclfmt](https://github.com/fatih/vim-hclfmt.git)
* [github.com/Yggdroot/indentLine](https://github.com/Yggdroot/indentLine.git)
* [github.com/elzr/vim-json](https://github.com/elzr/vim-json.git)
* [github.com/plasticboy/vim-markdown](https://github.com/plasticboy/vim-markdown.git)
* [github.com/harenome/vim-mipssyntax](https://github.com/harenome/vim-mipssyntax.git)
* [github.com/terryma/vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors.git)
* [github.com/uarun/vim-protobuf](https://github.com/uarun/vim-protobuf.git)
* [github.com/hynek/vim-python-pep8-indent](https://github.com/hynek/vim-python-pep8-indent.git)
* [github.com/mhinz/vim-sayonara](https://github.com/mhinz/vim-sayonara.git)
* [github.com/tpope/vim-sensible](https://github.com/tpope/vim-sensible.git)
* [github.com/tpope/vim-surround](https://github.com/tpope/vim-surround.git)
* [github.com/wgwoods/vim-systemd-syntax](https://github.com/wgwoods/vim-systemd-syntax.git)
* [github.com/hashivim/vim-terraform](https://github.com/hashivim/vim-terraform.git)
* [github.com/cespare/vim-toml](https://github.com/cespare/vim-toml.git)
* [github.com/stephpy/vim-yaml](https://github.com/stephpy/vim-yaml.git)

## Contributing

### Using the `Makefile`

You can use the [`Makefile`](Makefile) to run a series of commands.

```console
$ make help
install                        Sets up symlink for user and root .vimrc for vim and neovim.
README.md                      Generates and updates plugin info in README.md.
remove-submodule               Removes a git submodule (ex MODULE=bundle/nginx.vim).
update-pathogen                Updates pathogen.
update-plugins                 Updates all plugins.
update                         Updates pathogen and all plugins.
```