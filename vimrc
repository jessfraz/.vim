" load plugins
execute pathogen#infect()
call pathogen#helptags()

set nocompatible              " be iMproved, required
set nofoldenable              " disable folding
filetype off                  " required

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

"
" Settings
"
set noerrorbells                " No beeps
set number                      " Show line numbers
set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing

set noswapfile                  " Don't use swapfile
set nobackup					          " Don't create annoying backup files
set nowritebackup
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set encoding=UTF-8              " Set default encoding to UTF-8
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set laststatus=2
set hidden

set ruler                       " Show the cursor position all the time
au FocusLost * :wa              " Set vim to save the file on focus out.

set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats

set noshowmode                  " We show the mode with airline or lightline
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set ttyfast
" set ttyscroll=3               " noop on linux ?
set lazyredraw          	      " Wait to redraw "

" speed up syntax highlighting
set nocursorcolumn
set nocursorline

syntax sync minlines=256
set synmaxcol=300
set re=1

" do not hide markdown
set conceallevel=0

" open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

" Make Vim to handle long lines nicely.
set wrap
set textwidth=80
set formatoptions=qrn1

" Do not use relative numbers to where the cursor is.
set norelativenumber

" Apply the indentation of the current line to the next line.
set autoindent
set smartindent
set complete-=i
set showmatch
set smarttab

set tabstop=4
set shiftwidth=4
set expandtab

set nrformats-=octal
set shiftround

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10
" By default timeoutlen is 1000 ms
set timeoutlen=500

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone

if &history < 1000
  set history=50
endif

if &tabpagemax < 50
  set tabpagemax=50
endif

if !empty(&viminfo)
  set viminfo^=!
endif

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" CTRL-U in insert mode deletes a lot.	Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" If Linux then set ttymouse
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux" && !has('nvim')
  set ttymouse=xterm
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \	exe "normal! g`\"" |
      \ endif

syntax enable
if has('gui_running')
  set transparency=3
  " fix js regex syntax
  set regexpengine=1
  syntax enable
endif

if has('nvim')
  let g:tokyonight_style = "night"
  let g:tokyonight_italic_functions = 1
  let g:tokyonight_transparent = 1
  colorscheme tokyonight
else
  set background=dark
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
  colorscheme solarized
endif

set guifont=Inconsolata:h15
set guioptions-=L

" This comes first, because we have mappings that depend on leader
" With a map leader it's possible to do extra key combinations
" i.e: <leader>w saves the current file
let g:mapleader = ","
" ============================= vim-which-key ============================
" Setup WhichKey here for our leader.
" TODO: figure out why the timeout doesn't work
nnoremap <silent> <leader> :<c-u>WhichKey ','<CR>
call which_key#register(',', "g:which_key_map")
" Define prefix dictionary
let g:which_key_map =  {}
nnoremap <leader>? :WhichKey ','<CR>
let g:which_key_map['?'] = 'show help'

" This trigger takes advantage of the fact that the quickfix window can be
" easily distinguished by its file-type, qf. The wincmd J command is
" equivalent to the Ctrl+W, Shift+J shortcut telling Vim to move a window to
" the very bottom (see :help :wincmd and :help ^WJ).
autocmd FileType qf wincmd J

" Dont show me any output when I build something
" Because I am using quickfix for errors
"nmap <leader>m :make<CR><enter>

" Replace the current buffer with the given new file. That means a new file
" will be open in a buffer while the old one will be deleted
com! -nargs=1 -complete=file Breplace edit <args>| bdelete #

function! DeleteInactiveBufs()
  "From tabpagebuflist() help, get a list of all buffers in all tabs
  let tablist = []
  for i in range(tabpagenr('$'))
    call extend(tablist, tabpagebuflist(i + 1))
  endfor

  "Below originally inspired by Hara Krishna Dara and Keith Roberts
  "http://tech.groups.yahoo.com/group/vim/message/56425
  let nWipeouts = 0
  for i in range(1, bufnr('$'))
    if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
      "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
      silent exec 'bwipeout' i
      let nWipeouts = nWipeouts + 1
    endif
  endfor
  echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Ball :call DeleteInactiveBufs()

" Close quickfix easily
nnoremap <leader>a :cclose<CR>
let g:which_key_map.a = 'close quickfix'

" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>
let g:which_key_map['<space>'] = 'remove search highlight'

function! InsertDate()
  " Get the position of the cursor, if it is the start of the file we want
  " a different behavior than if it is elsewhere.
  let cursor_pos = getpos(".")
  let now = trim(system('date'))
  if cursor_pos[1] == "1"
    if cursor_pos[2] == "1"
      call append(0, [now, "", "- "])
      call cursor(cursor_pos[1]+2, 2)
    endif
  else
    call append(cursor_pos[1], ["", now, "", "- "])
    call cursor(cursor_pos[1]+4, 2)
  endif
endfunction

" Add a date timestamp between two new lines.
nnoremap <leader>d :call InsertDate()<CR>
let g:which_key_map.d = 'insert date'

" Buffer prev/next
nnoremap <C-x> :bnext<CR>
nnoremap <C-z> :bprev<CR>

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Fast saving
nmap <leader>w :w!<cr>
let g:which_key_map.w = 'save'

" Fresh vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" Center the screen
nnoremap <space> zz

" Move up and down on splitted lines (on small width screens)
map <Up> gk
map <Down> gj
map k gk
map j gj

" Just go out in insert mode
imap jk <ESC>l

" spell check
nnoremap <F6> :setlocal spell! spell?<CR>

" disable the recording macro, drives me nuts.
map q <Nop>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Set the path to where the current file is.
nnoremap <leader>. :lcd %:p:h<CR>
let g:which_key_map['.'] = 'set path as current file'

" When we open vim try and find the project root based on .git.
function! FindGitRoot()
  if &buftype ==? ''
    " The function doesn't work with autochdir
    set noautochdir

    " The function only works with local directories
    if expand('%:p') =~? '://'
      return
    endif

    " Start in open file's directory
    silent! lcd %:p:h
    let l:liststart = 0

    let l:pattern = '.git'
    let l:fullpath = finddir(l:pattern, ';')

    " Split the directory into path/match
    let l:match = matchstr(l:fullpath, '\m\C[^\/]*$')
    let l:path = matchstr(l:fullpath, '\m\C.*\/')

    " $HOME + match
    let l:home = $HOME . '/' . l:pattern

    " If the search hits home try the next item in the list.
    " Once a match is found break the loop.
    if l:fullpath == l:home
      let l:liststart = l:liststart + 1
      lcd %:p:h
    endif

    " If path is anything but blank
    if l:path !=? ''
      exe 'lcd' . ' ' l:path
    endif

    if g:root#echo == 1 && l:match !=? ''
      echom 'Found' l:match 'in' getcwd()
    elseif g:root#echo == 1
      echom 'Root dir not found'
    endif
  endif
endfunction

" Find the git directory root on open of vim.
autocmd BufEnter * silent! FindGitRoot

" Do not show stupid q: window
map q: :q

" Sometimes this happens and I hate it
map :Vs :vs
map :Sp :sp

" dont save .netrwhist history
let g:netrw_dirhistmax=0

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" never do this again --> :set paste <ctrl-v> :set no paste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" Set 80 character line limit
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" ----------------------------------------- "
" File Type settings 			    		"
" ----------------------------------------- "

au BufNewFile,BufRead *.vim setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
au BufNewFile,BufRead *.md setlocal spell noet ts=4 sw=4
au BufNewFile,BufRead *.yml,*.yaml setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.cpp setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.hpp setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.json setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.jade setlocal expandtab ts=2 sw=2

augroup filetypedetect
  au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  au BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
augroup END

au FileType nginx setlocal noet ts=4 sw=4 sts=4

" mutt mail line wrapping
au BufRead /tmp/mutt-* set textwidth=80

" Go settings
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
" autocmd BufEnter *.go colorscheme nofrils-dark

" scala settings
autocmd BufNewFile,BufReadPost *.scala setl shiftwidth=2 expandtab

" lua settings
autocmd BufNewFile,BufRead *.lua setlocal noet ts=4 sw=4 sts=4

" Dockerfile settings
autocmd FileType dockerfile set noexpandtab

" shell/config/systemd settings
autocmd FileType fstab,systemd set noexpandtab
autocmd FileType gitconfig,sh,toml set noexpandtab

" python indent
autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80 smarttab expandtab

" For all text files set 'textwidth' to 80 characters.
autocmd FileType text setlocal textwidth=80 fo+=2t ts=2 sw=2 sts=2 expandtab
autocmd BufNewFile,BufRead *.md,*.txt,*.adoc setlocal textwidth=80 fo+=2t ts=2 sw=2 sts=2 expandtab

" toml settings
au BufRead,BufNewFile MAINTAINERS,*.toml set ft=toml formatprg=toml-fmt

au BufRead,BufNewFile Fastfile,Appfile,Podfile set ft=ruby

" hcl settings
au BufRead,BufNewFile *.workflow set ft=hcl

" mips settings
au BufRead,BufNewFile *.mips set ft=mips

" settings for njk
au BufRead,BufNewFile *.njk,*.hbs set ft=html

" Binary settings: edit binary using xxd-format
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

" spell check for git commits
autocmd FileType gitcommit setlocal spell

" Wildmenu completion {{{
set wildmenu
" set wildmode=list:longest
set wildmode=list:full

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=go/pkg                           " Go static files
set wildignore+=go/bin                           " Go bin files
set wildignore+=go/bin-vagrant                   " Go bin-vagrant files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files


" ----------------------------------------- "
" Plugin configs 			    			            "
" ----------------------------------------- "

" ==================== nvim-web-devicons ====================
if has('nvim')
lua << EOF
require'nvim-web-devicons'.setup{
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true;
}
EOF
endif

" ==================== telescope.nvim ====================
if has('nvim')
  let g:which_key_map.f = { 'name' : '+telescope find' }
  nnoremap <leader>ff <cmd>Telescope find_files<CR>
  let g:which_key_map.f.f = 'telescope find files'
  nnoremap <leader>fg <cmd>Telescope live_grep<CR>
  let g:which_key_map.f.g = 'telescope live grep'
  nnoremap <leader>fb <cmd>Telescope buffers<CR>
  let g:which_key_map.f.b = 'telescope buffers'
  nnoremap <leader>fh <cmd>Telescope help_tags<CR>
  let g:which_key_map.f.h = 'telescope help tags'

  " Make Ctrl-p work for telescope since we know those keybindings so well.
  nnoremap <C-p> <cmd>Telescope find_files<CR>
  nnoremap <C-g> <cmd>Telescope live_grep<CR>
  nnoremap <C-b> <cmd>Telescope git_branches<CR>

  if !executable('rg')
    echo "You might want to install ripgrep: https://github.com/BurntSushi/ripgrep#installation"
  endif

lua << EOF
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        -- map actions.which_key to ?
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["?"] = "which_key"
      }
    },
    file_ignore_patterns = {
      "^.git/",
      ".DS_Store",
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      find_command = {"rg", "--ignore", "--hidden", "--files"},
      },
    live_grep = {
      theme = "dropdown",
      },
    buffers = {
      theme = "dropdown",
      },
    git_branches = {
      theme = "dropdown",
      },
  },
  extensions = {
  }
}
EOF
endif

" ==================== bufferline.nvim ====================
if has('nvim')
  set termguicolors

lua << EOF
require("bufferline").setup{
  options = {
    diagnostics = "nvim_lsp",
    }
}
EOF
endif

" ================== vim-fugitive ====================
" TODO: autocomplete issues urls collaborators in commit messages
let g:which_key_map.g = { 'name' : '+git' }
nnoremap <leader>ga :Git add %:p<CR><CR>
let g:which_key_map.g.a = 'git add current file'
nnoremap <leader>gs :Git<CR>
let g:which_key_map.g.s = 'git status'
nnoremap <leader>gp :Git push<CR><CR>
let g:which_key_map.g.p = 'git push'
nnoremap <leader>gb :Git blame<CR>
let g:which_key_map.g.b = 'git blame'
nnoremap <leader>gc :Git commit -sa<CR><CR>
let g:which_key_map.g.c = 'git commit'
nnoremap <leader>go :GBrowse<CR><CR>
let g:which_key_map.g.o = 'open in GitHub'

" ==================== gitsigns.nvim ====================
if has('nvim')
lua << EOF
require("gitsigns").setup{
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '_¯', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~_', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  keymaps = {
    -- Default keymap options
    noremap = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    ['n <leader>gd'] = '<cmd>lua require"gitsigns".diffthis()<CR>',
  },
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
  },
  current_line_blame_formatter_opts = {
    relative_time = true
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}
EOF
endif

" ==================== vim-go ====================
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_term_enabled = 1
let g:go_snippet_engine = "neosnippet"
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_operators = 0
let g:go_highlight_build_constraints = 1
let g:go_fmt_autosave = 1

au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>l <Plug>(go-metalinter)

au FileType go nmap <leader>r  <Plug>(go-run)

au FileType go nmap <leader>b  <Plug>(go-build)
au FileType go nmap <leader>t  <Plug>(go-test)
au FileType go nmap <leader>dt  <Plug>(go-test-compile)
au FileType go nmap <Leader>d <Plug>(go-doc)

au FileType go nmap <Leader>e <Plug>(go-rename)

" neovim specific
if has('nvim')
  au FileType go nmap <leader>rt <Plug>(go-run-tab)
  au FileType go nmap <Leader>rs <Plug>(go-run-split)
  au FileType go nmap <Leader>rv <Plug>(go-run-vertical)
endif

" I like these more!
augroup go
  autocmd!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

" ==================== nvim-tree.lua ====================
noremap <C-a> :NvimTreeToggle<CR>

let g:which_key_map.n = { 'name' : '+file tree' }
noremap <leader>nn :NvimTreeToggle<cr>
" find the current file in the tree
let g:which_key_map.n.n = 'file tree toggle'
noremap <leader>nf :NvimTreeFindFile<cr>
let g:which_key_map.n.f = 'file tree find file'

let g:nvim_tree_gitignore = 1
let g:nvim_tree_add_trailing = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_git_hl = 1

if has('nvim')
lua << EOF
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

require'nvim-tree'.setup{
  -- Setting this to true breaks :GBrowse & vim-rhubarb.
  disable_netrw = false,
  -- Close nvim-tree and vim on close file
  auto_close = true,
  -- TODO: Make this work
  filters = {
    '.git',
    '.DS_Store',
    },
  view = {
    mappings = {
      list = {
        { key = "?", cb = tree_cb("toggle_help") },
        -- this annoys me when i think I am saving a file and get an error
        -- so just refresh the tree
        { key = ":w", cb = tree_cb("refresh") },
        -- move the file
        { key = "m", cb = tree_cb("rename") },
        -- refresh the tree
        { key = "r", cb = tree_cb("refresh") },
      }
    }
  }
}
EOF
endif

" ==================== vim-json ====================
let g:vim_json_syntax_conceal = 0

" ========= vim-better-whitespace ==================
" do not highlight the whitespace
let g:better_whitespace_enabled=0
" auto strip whitespace except for file with extention blacklisted
let blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown']
autocmd BufWritePre * if index(blacklist, &ft) < 0 | StripWhitespace

" ========= vim-markdown ==================
" disable folding
let g:vim_markdown_folding_disabled = 1

" Allow for the TOC window to auto-fit when it's possible for it to shrink.
" It never increases its default size (half screen), it only shrinks.
let g:vim_markdown_toc_autofit = 1

" Disable conceal
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" Allow the ge command to follow named anchors in links of the form
" file#anchor or just #anchor, where file may omit the .md extension as usual
let g:vim_markdown_follow_anchor = 1

" highlight frontmatter
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

" =================== lualine.nvim ========================
if has('nvim')
lua << EOF
require('lualine').setup{
  options = {
    theme = 'tokyonight'
    }
  }
EOF
endif

" =================== rust.vim ========================
" Enable automatic running of :RustFmt when a buffer is saved.
let g:rustfmt_autosave = 1

" The :RustPlay command will send the current selection, or if nothing is
" selected the current buffer, to the Rust playpen. Then copy the url to the
" clipboard.
if has('macunix')
  let g:rust_clip_command = 'pbcopy'
else
  let g:rust_clip_command = 'xclip -selection clipboard'
endif

" =================== vim-terraform ========================

" Allow vim-terraform to override your .vimrc indentation syntax for matching files.
let g:terraform_align=1

" Run terraform fmt on save.
let g:terraform_fmt_on_save=1

" =================== copilot.vim ========================

hi def CopilotSuggestion guifg=#808080 ctermfg=242

" =================== nvim-lspconfig ========================

if has('nvim-0.5')

" =================== clangd ========================
if executable('clangd')
lua << EOF
require'lspconfig'.clangd.setup{}
EOF
else
  echo "You might want to install clangd: https://clangd.llvm.org/installation.html"
endif

" =================== gopls ========================
if executable('gopls')
lua << EOF
require'lspconfig'.gopls.setup{}
EOF
else
  echo "You might want to install gopls: https://github.com/golang/tools/tree/master/gopls"
endif

" =================== rust-analyzer ========================
if executable('rust-analyzer')
lua << EOF
local nvim_lsp = require'lspconfig'

nvim_lsp.rust_analyzer.setup({
  -- on_attach is a callback called when the language server attachs to the buffer
  -- on_attach = on_attach,
  settings = {
    -- config from: https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer"] = {
      -- enable clippy diagnostics on save
      checkOnSave = {
        command = "clippy"
      },
    }
  }
})
EOF
else
  echo "You might want to install rust-analyzer: https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary"
endif

endif

" =================== tsserver ========================
if executable('tsserver')
lua << EOF
require'lspconfig'.tsserver.setup{}
EOF
else
  echo "You might want to install tsserver: npm install -g typescript typescript-language-server"
endif

" =================== nvim-cmp ========================

if has('nvim-0.5')

lua << EOF
-- Add additional capabilities supported by nvim-cmp
local nvim_lsp = require'lspconfig'
local cmp = require'cmp'

cmp.setup ({
  snippet = {
    -- Enable LSP snippets
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'cmdline' },
  },
})

-- Setup lspconfig.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

EOF

endif

" =================== lspsaga.nvim =========================
if has('nvim')
" lsp provider to find the cursor word definition and reference
nnoremap <silent> gh :Lspsaga lsp_finder<CR>

" preview definition
nnoremap <silent> gd :Lspsaga preview_definition<CR>

" rename
nnoremap <silent> gr :Lspsaga rename<CR>

" show signature help
nnoremap <silent> gs :Lspsaga signature_help<CR>

" show hover doc
nnoremap <silent>K :Lspsaga hover_doc<CR>
" scroll down hover doc or scroll in definition preview
" nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
" nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" code action
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>

" float terminal also you can pass the cli command in open_float_terminal function
nnoremap <silent> <C-t> :Lspsaga open_floaterm<CR>
tnoremap <silent> <C-t> <C-\><C-n>:Lspsaga close_floaterm<CR>

lua << EOF
require'lspsaga'.init_lsp_saga{
  use_saga_diagnostic_sign = true,
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  infor_sign = '',
  dianostic_header_icon = '   ',
  code_action_icon = ' ',
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 20,
    virtual_text = true,
    },
  finder_definition_icon = '  ',
  finder_reference_icon = '  ',
  max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
  finder_action_keys = {
    open = 'o',
    vsplit = 's',
    split = 'i',
    quit = 'q',
    scroll_down = '<C-f>',
    scroll_up = '<C-b>',
    },
  code_action_keys = {
    quit = 'q',
    exec = '<CR>'
    },
  rename_action_keys = {
    quit = '<C-c>',
    exec = '<CR>',
    },
  definition_preview_icon = '  ',
  -- "single" "double" "round" "plus"
  border_style = "single",
  rename_prompt_prefix = '➤',
}
EOF
endif


" =================== indent-blankline.nvim ========================
if has('nvim')
lua << EOF
require("indent_blankline").setup {
  char = "|",
  buftype_exclude = {"terminal"},
  filetype_exclude = {"dashboard"},
  show_end_of_line = false,
}
EOF
endif

" =================== dashboard-nvim ========================
let g:dashboard_default_executive ='telescope'

" disable the tabline in the dashboard
autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2

" vim:ts=2:sw=2:et
