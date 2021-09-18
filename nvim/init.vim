call plug#begin('~/.local/share/nvim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
call plug#end()

colorscheme dracula

language en_US

" vim-airline config---------------------------"
" Use Powerline fonts
let g:airline_powerline_fonts = 1
" End vim-airline config-----------------------"

let g:coc_global_extensions = [
  \ 'coc-solargraph',
  \ 'coc-sh',
  \ ]

" Enable True Color
set termguicolors

" Show line numbers
set number

" Yank to system clipboard
set clipboard=unnamed

" Show invisible characters
set list

" Case insensitive search
set ignorecase
" Case sensitive search when uppercase is included
set smartcase

" Use spaces with <Tab>
set expandtab
" Number of spaces for <Tab> when opening a file
set tabstop=2
" Number of spaces when entered <Tab>
set softtabstop=2
" Number of spaces for (auto) indent
set shiftwidth=2

" Restore cursor position
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" Disable search highlights
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
