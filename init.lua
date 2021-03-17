require('plugins')
require('config')
require('config.bh-galaxyline')
require('config.bh-nvim-compe')
require('config.bh-lspkind')
require('config.bh-nvim-tree')
require('config.bh-treesitter')
require('lsp')

-- =======================
-- 		Basics
-- =======================
vim.g.mapleader = [[ ]]
vim.cmd('colorscheme edge')
vim.o.syntax = 'on'
vim.o.compatible = false
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true -- for accurate colors
vim.o.hidden = true -- allows you to save buffers that you might still want to jump to
vim.o.wildmenu = true -- statusline command completion
vim.o.backspace = 'indent,eol,start' -- allow backspacing over autoindent, line breaks and start of insert action
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.o.autoindent = true -- keeps indent from the line above
vim.o.startofline = false -- stop certain movements from going to the first character of the line
vim.o.confirm = true -- ask to save file before quit
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
vim.wo.wrap = false
vim.o.swapfile = false -- no more pesky .swp file warnings--
vim.cmd('set clipboard+=unnamedplus') -- the system clipboard is enabled--
vim.o.inccommand = 'split'
vim.o.autochdir = true
vim.o.scrolloff = 4
vim.o.lazyredraw = false -- don't show me the execution of macros--
vim.g.python3_host_prog = '/bin/python3'
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

-- substitute word under cursor
-- setmap('n', '<Leader>sw', ':%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>', opt)

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
setmap('n', '<Leader>fs', ':w<CR>', opt)
setmap('n', '<Leader>fq', ':q', opt)
setmap('n', '<Leader>v', ':luafile $MYVIMRC<CR>', silence)
