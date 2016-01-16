call plug#begin('~/.vim/plugged')

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'flazz/vim-colorschemes'

" vimproc
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" vim-airline
Plug 'vim-airline/vim-airline'

" C++ syntax highlighting
Plug 'vim-jp/cpp-vim', { 'for': 'cpp' }

" Completion
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neoinclude.vim'
Plug 'justmao945/vim-clang'
" Auto completion for quotes etc
Plug 'Raimondi/delimitMate'

" quickrun.vim
Plug 'thinca/vim-quickrun'

" obsession.vim
Plug 'tpope/vim-obsession'

" unimpaired.vim
Plug 'tpope/vim-unimpaired'

" abolish.vim
Plug 'tpope/vim-abolish'

call plug#end()

" Neosnippet config-----------------------------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
"End Neosnippet config-------------------------"

" neocomplete and vim-clang config-------------"
let g:neocomplete#enable_at_startup = 1

" disable auto completion for vim-clang
let g:clang_auto = 0
" default 'longest' can not work with neocomplete
let g:clang_c_completeopt = 'menuone,preview'
let g:clang_cpp_completeopt = 'menuone,preview'

" use neocomplete
" input patterns
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

" for c and c++
let g:neocomplete#force_omni_input_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

let g:clang_c_options = '-std=gnu11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
"End neocomplete and vim-clang config----------"


" delimitMate config----------------------------
" Auto indent
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
"End delimitMate config------------------------"

" quickrun.vim config--------------------------"
let g:quickrun_config = {
\   "_" : {
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 60
\   },
\}
"End quickrun.vim config-----------------------"

" Enable matchit
runtime macros/matchit.vim

" Turn off vi compatible mode
set nocompatible

" Delete a character with backspace in insert mode
set backspace=start,eol,indent

" Syntax highlighting
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Always show status line
set laststatus=2
" Display long a path filename for status line
set statusline=%F%r%h%=

" Display line numbers
set number

" Incremental search
set incsearch
" Case insensitive search
set ignorecase
" Case sensitive search when uppercase is included
set smartcase
" Highlight searched strings
set hlsearch

" Completion format for command line mode
set wildmenu wildmode=list:full

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

" Bubble single lines
" Note: 'unimpaired.vim' is required
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Visually select the text that was last edited/pasted
nmap gV `[v`]
