require('bh-packer')
vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
  -- #region nvim
  use 'sainnhe/edge'
  -- plugin to the outlet
  use {'wbthomason/packer.nvim', opt = true}
  -- sources all the files in lua/plugin/
  use 'tjdevries/astronauta.nvim'
  -- Oh hey its me
  use {'BenGH28/neo-runner.nvim', run = ':UpdateRemotePlugins'}
  -- How can it be? Great scott we have an lsp!!
  use {
   'neovim/nvim-lspconfig',
   requires = {
      {'hrsh7th/nvim-compe'}, {'glepnir/lspsaga.nvim'}, {'onsails/lspkind-nvim'}
    }
  }
  -- "...I am the captain now"
  use { 'kabouzeid/nvim-lspinstall' }
  -- format
  use 'mhartington/formatter.nvim'
  -- colours to make unicorns vomit
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  -- I walk the line
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  -- file tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  -- file finder
  use {
    'nvim-lua/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  -- quotes, brackets and easy times ahead
  use 'windwp/nvim-autopairs'
  -- which bracket is this again?
  use 'p00f/nvim-ts-rainbow'
  -- jump around, jump around
  use 'phaazon/hop.nvim'
  -- the Lone Ranger
  use {
    'kevinhwang91/rnvimr',
    branch = 'main',
    config = function()
      vim.g.rnvimr_ex_enable = 1
    end
  }
  -- wait that hex code is a colour?
  use 'norcalli/nvim-colorizer.lua'
  -- a terminal within a terminal... trippy
  use 'akinsho/nvim-toggleterm.lua'
  -- I changed something didn't I?
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('gitsigns').setup()
    end
  }
  -- lets git kraken... oh wait wrong git app
  use 'kdheepak/lazygit.nvim'
  -- #endregion

  -- #region Vim
  -- comments are easy
  use 'tpope/vim-commentary'
  -- 'I have you completely surrounded'
  use 'tpope/vim-surround'
  -- do it again
  use 'tpope/vim-repeat'
  -- start screen for the vimified
  use 'mhinz/vim-startify'
  -- 360 no scope
  use 'unblevable/quick-scope'
  -- what was that shortcut again?
  use 'liuchengxu/vim-which-key'
  -- documentation for the enlightend
  use 'vim-scripts/DoxygenToolkit.vim'
  -- OCD and me
  use 'junegunn/vim-easy-align'
  -- snippets are my friend
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'rafamadriz/friendly-snippets'
  -- #endregion
end)

require('lsp')
-- =======================
-- 		Basics
-- =======================
vim.g.mapleader = " "
vim.g.python3_host_prog = '/bin/python3'
vim.cmd('colorscheme edge')
vim.cmd(':set cpo-=C')
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = false
vim.wo.signcolumn = 'yes'
vim.o.syntax = 'on'
vim.o.compatible = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true -- for accurate colors
vim.o.hidden = true -- allows you to save buffers that you might still want to jump to
vim.o.wildmenu = true -- statusline command completion
vim.o.backspace = 'indent,eol,start' -- allow backspacing over autoindent, line breaks and start of insert action
vim.o.autoindent = true -- keeps indent from the line above
vim.o.smartindent = true
vim.o.startofline = false -- stop certain movements from going to the first character of the line
vim.o.confirm = false -- ask to save file before quit
vim.o.laststatus = 2
vim.o.showmode = false -- gets rid of the redundant --insert--
vim.o.mouse = 'a' -- allow mouse use in all modes
vim.o.cmdheight = 2 -- command window height to 2 lines
vim.o.timeoutlen = 500
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.foldmethod = 'syntax'
vim.o.foldnestmax = 10
vim.o.foldenable = false
vim.o.swapfile = false -- no more pesky .swp file warnings--
vim.o.clipboard = 'unnamedplus' -- the system clipboard is enabled--
vim.o.inccommand = 'split'
vim.o.autochdir = true
vim.o.scrolloff = 4
vim.o.lazyredraw = false -- don't show me the execution of macros--
vim.o.completeopt = 'menuone,noselect'
-- =============================================================
--		Vim Mappings Only
-- =============================================================

-- alias the long function
local setmap = vim.api.nvim_set_keymap

local opt = {noremap = true}
local silence = {noremap = true, silent = true}

setmap('i', 'jk', '<ESC>', opt)
setmap('i', 'kj', '<ESC>', opt)

setmap('n', '<Leader>ma', ':make<CR>', opt)
setmap('n', '<Leader>mc', ':make clean<CR>', opt)
setmap('n', 'Y', 'y$', opt)
setmap('n', '0', '^', opt)

-- substitute word under cursor
-- :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
setmap('n', '<Leader>sw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
       opt)

setmap('n', '<Leader>bn', ':bNext<CR>', silence)
setmap('n', '<Leader>bp', ':bprevious<CR>', silence)

setmap('n', '<Leader>.', ':tabn<CR>', silence)
setmap('n', '<Leader>,', ':tabp<CR>', silence)

-- set background quickly if I'm not using alacritty
setmap('n', '<Leader>al', ':set background=light<CR>', silence)
setmap('n', '<Leader>ad', ':set background=dark<CR>', silence)

-- alacritty themes
setmap('n', '<Leader>at', ':call MyFunctions#ToggleAlacrittyTheme()<CR>',
       silence)

-- windows
setmap('n', '<C-h>', ':wincmd h<CR>', silence)
setmap('n', '<C-j>', ':wincmd j<CR>', silence)
setmap('n', '<C-k>', ':wincmd k<CR>', silence)
setmap('n', '<C-l>', ':wincmd l<CR>', silence)
setmap('n', '<Leader>wo', ':on<CR>', silence)

-- resizing splits
setmap('n', '<Leader>wh', ':vertical resize -3<CR>', silence)
setmap('n', '<Leader>wj', ':resize -3<CR>', silence)
setmap('n', '<Leader>wk', ':resize +3<CR>', silence)
setmap('n', '<Leader>wl', ':vertical resize +3<CR>', silence)
setmap('n', '<Leader>w=', '<C-W>=', silence)

-- to do with files
setmap('n', '<Leader>fv', ':e $MYVIMRC<CR>', silence)
setmap('n', '<Leader>fj', ':w<CR>', opt)
setmap('n', '<Leader>fq', ':q', opt)
setmap('n', '<Leader>v', ':luafile $MYVIMRC<CR>', opt)
