-- =======================
-- 		Basics
-- =======================
vim.g.mapleader = " "
vim.g.python3_host_prog = "/bin/python3"
vim.o.termguicolors = true -- for accurate colors
vim.cmd [[colorscheme edge]]
vim.cmd(":set cpo-=C")
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.syntax = "on"
vim.cmd [[filetype plugin indent on]]
vim.o.compatible = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hidden = true -- allows you to save buffers that you might still want to jump to
vim.o.wildmenu = true -- statusline command completion
vim.o.backspace = "indent,eol,start" -- allow backspacing over autoindent, line breaks and start of insert action
vim.o.autoindent = true -- keeps indent from the line above
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.startofline = false -- stop certain movements from going to the first character of the line
vim.o.confirm = false -- ask to save file before quit
vim.o.laststatus = 2
vim.o.showmode = false -- gets rid of the redundant --insert--
vim.o.mouse = "a" -- allow mouse use in all modes
vim.o.cmdheight = 1 -- command window height to 2 lines
vim.o.timeoutlen = 500
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.foldmethod = "syntax"
vim.o.foldnestmax = 10
vim.o.foldenable = false
vim.o.swapfile = false -- no more pesky .swp file warnings--
vim.o.clipboard = "unnamedplus" -- the system clipboard is enabled--
vim.o.inccommand = "split"
vim.o.autochdir = true
vim.o.scrolloff = 4
vim.o.lazyredraw = false -- don't show me the execution of macros--
vim.o.completeopt = "menuone,noselect"
vim.o.list = true
vim.opt.listchars = {
  tab = "| ",
  eol = "⤶",
  precedes = "«",
  extends = "»"
}
vim.o.undodir = ".undo/"
vim.o.undofile = true