call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
call plug#end()

" Tokyo Night colorscheme
set termguicolors
colorscheme catppuccin_mocha

" delimitMate config----------------------------
" Auto indent
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
"End delimitMate config------------------------"

" vim-airline config---------------------------"
" Use Powerline fonts
let g:airline_powerline_fonts = 1
" End vim-airline config-----------------------"

" Enable matchit
runtime macros/matchit.vim

" Turn off vi compatible mode
set nocompatible

" Enable file type detection
filetype plugin indent on

" Yank to system clipboard
set clipboard=unnamed

" Delete a character with backspace in insert mode
set backspace=start,eol,indent

" Show line numbers
set number
" Show invisible characters
set list
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Incremental search
set incsearch
" Case insensitive search
set ignorecase
" Case sensitive search when uppercase is included
set smartcase
" Highlight searched strings
set hlsearch

" Completion menu for command line mode (zsh style)
set wildmenu wildmode=full

" Use spaces with <Tab>
set expandtab
" Number of spaces for <Tab> when opening a file
set tabstop=2
" Number of spaces when entered <Tab>
set softtabstop=2
" Number of spaces for (auto) indent
set shiftwidth=2
" Auto indent
set autoindent
" Disable auto insertion of comment
if has("autocmd")
  autocmd FileType * set formatoptions-=c formatoptions-=r formatoptions-=o
endif

" Don't treat a 0 prefixed number as a octal when entered <C-a>
set nrformats=

" Maximum number for Ex command history
set history=200

" Restore cursor position
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

" Map <Space> to Leader key
nnoremap <Space> <NOP>
let mapleader = "\<Space>"

" Expand the directory of the current file at command line by %%
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
" Open files located in the same directory as the current file
map <Leader>ew :e %%
map <Leader>es :sp %%
map <Leader>ev :vsp %%
map <Leader>et :tabe %%

" Move command history by <C-p>, <C-n>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Disable search highlights
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Move single lines
" Note: 'unimpaired.vim' is required
" Key bindings are same as JetBrains IDEs
nmap <M-S-Up> [e
nmap <M-S-Down> ]e
" Move multiple lines
vmap <M-S-Up> [egv
vmap <M-S-Down> ]egv

" Visually select the text that was last edited/pasted
nmap gV `[v`]

" Open file
nnoremap <silent> <Leader>o :Files<CR>
