.vim
====

My vim dot files. the `.vimrc` file is saved to [vimrc](https://github.com/jessfraz/.vim/blob/master/vimrc).

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

## Shortcuts

- `Ctrl-P`: Find files
- `Ctrl-G`: Live grep
- `Ctrl-A`: Toggle the file sidebar
- `Ctrl-R`: Refresh the file sidebar
- `Ctrl-N`: Multiple cursor support
- `Ctrl-X`: Switch to the next buffer
- `Ctrl-Z`: Switch to the previous buffer

## Plugins Used
* [github.com/akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim.git)
* [github.com/hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline.git)
* [github.com/hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp.git)
* [github.com/hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path.git)
* [github.comhub/copilot.vim.git](https://github.com/github/copilot.vim.git)
* [github.com/glepnir/lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim.git)
* [github.com/nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim.git)
* [github.com/chr4/nginx.vim](https://github.com/chr4/nginx.vim.git)
* [github.com/hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp.git)
* [github.com/neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig.git)
* [github.com/kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua.git)
* [github.com/nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter.git)
* [github.com/kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons.git)
* [github.com/nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim.git)
* [github.com/rust-lang/rust.vim](https://github.com/rust-lang/rust.vim.git)
* [github.com/nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git)
* [github.com/folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim.git)
* [github.com/leafgarland/typescript-vim](https://github.com/leafgarland/typescript-vim.git)
* [github.com/ntpeters/vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace.git)
* [github.com/altercation/vim-colors-solarized](https://github.com/altercation/vim-colors-solarized.git)
* [github.com/tpope/vim-endwise](https://github.com/tpope/vim-endwise.git)
* [github.com/tpope/vim-five.git](https://github.com/tpope/vim-fugitive.git)
* [github.com/tpope/vim.git](https://github.com/tpope/vim-git.git)
* [github.com/airblade/vimgutter.git](https://github.com/airblade/vim-gitgutter.git)
* [github.com/fatih/vim-go](https://github.com/fatih/vim-go.git)
* [github.com/Yggdroot/indentLine](https://github.com/Yggdroot/indentLine.git)
* [github.com/elzr/vim-json](https://github.com/elzr/vim-json.git)
* [github.com/MaxMEllon/vim-jsx-pretty](https://github.com/MaxMEllon/vim-jsx-pretty.git)
* [github.com/plasticboy/vim-markdown](https://github.com/plasticboy/vim-markdown.git)
* [github.com/harenome/vim-mipssyntax](https://github.com/harenome/vim-mipssyntax.git)
* [github.com/uarun/vim-protobuf](https://github.com/uarun/vim-protobuf.git)
* [github.com/hynek/vim-python-pep8-indent](https://github.com/hynek/vim-python-pep8-indent.git)
* [github.com/tpope/vim-sensible](https://github.com/tpope/vim-sensible.git)
* [github.com/tpope/vim-surround](https://github.com/tpope/vim-surround.git)
* [github.com/wgwoods/vim-systemd-syntax](https://github.com/wgwoods/vim-systemd-syntax.git)
* [github.com/hashivim/vim-terraform](https://github.com/hashivim/vim-terraform.git)
* [github.com/cespare/vim-toml](https://github.com/cespare/vim-toml.git)
* [github.com/mg979/vim-visual-multi](https://github.com/mg979/vim-visual-multi.git)
* [github.com/liuchengxu/vim-which-key](https://github.com/liuchengxu/vim-which-key.git)
* [github.com/stephpy/vim-yaml](https://github.com/stephpy/vim-yaml.git)
