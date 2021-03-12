call MyFunctions#AlignAlacrittyBackground()

"=============================================================
"							vim-plug
"=============================================================
call plug#begin('~/.vim/plugged')

Plug 'BenGH28/neo-runner.nvim', {'do': ':UpdateRemotePlugins'}

"Pretty {{{
Plug 'sainnhe/edge'
Plug 'mhinz/vim-startify'
"}}}

"LSP {{{
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
"}}}

"Languages and Syntax{{{
Plug 'dense-analysis/ale'
Plug 'rust-lang/rust.vim'
Plug 'vim-python/python-syntax'
Plug 'rhysd/vim-clang-format'
Plug 'bfrg/vim-cpp-modern', !has('nvim-0.5') ? {} : {'on': []}
Plug 'suan/vim-instant-markdown'
"}}}

"Tools {{{
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
Plug 'puremourning/vimspector'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lilydjwg/colorizer'
Plug 'unblevable/quick-scope'
Plug 'mhinz/vim-signify'
Plug 'voldikss/vim-floaterm'
Plug 'kevinhwang91/rnvimr', {'branch': 'main'}
Plug 'liuchengxu/vim-which-key'
Plug 'rstacruz/vim-closer'
Plug 'nvim-treesitter/nvim-treesitter', has('nvim-0.5') ? {'do':':TSUpdate'} : {'on': []}
"this needs to be called at the end to work correctly
Plug 'ryanoasis/vim-devicons'
"}}}

call plug#end()

"=======================
"     luafiles
"=======================
luafile $HOME/.config/nvim/lua/plugin/nvim-compe.lua
luafile $HOME/.config/nvim/lua/plugin/lspsaga.lua

luafile $HOME/.config/nvim/lua/lsp/bashls-lsp.lua
luafile $HOME/.config/nvim/lua/lsp/jsonls-lsp.lua
luafile $HOME/.config/nvim/lua/lsp/ccls-lsp.lua
luafile $HOME/.config/nvim/lua/lsp/pyls-lsp.lua
luafile $HOME/.config/nvim/lua/lsp/rls-lsp.lua
luafile $HOME/.config/nvim/lua/lsp/vimls-lsp.lua
luafile $HOME/.config/nvim/lua/lsp/yamlls-lsp.lua

"=======================
"		Basics
"=======================
"{{{
let mapleader = "\<Space>"
set encoding=utf-8
colorscheme edge
set nocompatible
set number relativenumber
syntax on
set ignorecase
set smartcase
set termguicolors "for accurate colors
set hidden "allows you to save buffers that you might still want to jump to
set wildmenu "statusline command completion
set backspace=indent,eol,start "allow backspacing over autoindent, line breaks and start of insert action
set shiftwidth=4
set tabstop=4
set autoindent "keeps indent from the line above
set nostartofline "stop certain movements from going to the first character of the line
set confirm "ask to save file before quit
set laststatus=2
set noshowmode "gets rid of the redundant --insert--
set mouse=a "allow mouse use in all modes
set cmdheight=2 "command window height to 2 lines
set timeoutlen=500
set cursorline
set splitbelow
set splitright
filetype plugin on "detect filetype
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set nowrap
set noswapfile  "no more pesky .swp file warnings"
set clipboard+=unnamedplus "the system clipboard is enabled"
set inccommand=split
set autochdir
set scrolloff=4
set nolazyredraw      "don't show me the execution of macros"
let g:python3_host_prog = '/bin/python3'
set completeopt=menuone,noselect
"}}}

"=============================================================
"		Vim Mappings Only
"=============================================================
inoremap jk <ESC>
inoremap kj <ESC>

nnoremap <Leader>ma :make<CR>
nnoremap <Leader>mc :make clean<CR>

"substitute word under cursor
nnoremap <Leader>sw :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

nnoremap <silent> <Leader>bn :bNext<CR>
nnoremap <silent> <Leader>bp :bprevious<CR>

nnoremap <silent> <Leader>. :tabn<CR>
nnoremap <silent> <Leader>, :tabp<CR>

"set background quickly if I'm not using alacritty
nnoremap <silent> <Leader>al :set background=light<CR>
nnoremap <silent> <Leader>ad :set background=dark<CR>

"alacritty themes
nnoremap <silent> <Leader>at :call MyFunctions#ToggleAlacrittyTheme()<CR>

"windows {{{
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nmap <silent> <Leader>wo :on<CR>
"}}}

"resizing splits {{{
nnoremap <silent> <Leader>wh :vertical resize -3<CR>
nnoremap <silent> <Leader>wj :resize -3<CR>
nnoremap <silent> <Leader>wk :resize +3<CR>
nnoremap <silent> <Leader>wl :vertical resize +3<CR>
nnoremap <silent> <Leader>w= <C-W>=
"}}}

"to do with files {{{
nnoremap <Leader>fv :e $MYVIMRC<CR>
nnoremap <Leader>fs :w<CR>
nnoremap <Leader>fq :q<CR>
nnoremap <Leader>v :source $MYVIMRC<CR>
"}}}
