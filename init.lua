require "packer-config"
vim.cmd [[packadd packer.nvim]]
require "packer".startup(
  function(use)
    local lsp_file_list = {"yaml", "cpp", "c", "python", "json", "lua", "rust", "bash"}
    --#region General Dependencies
    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {"kyazdani42/nvim-web-devicons"}
    --#endregion

    --#region Lsp
    use {
      "hrsh7th/nvim-compe",
      ft = lsp_file_list
    }
    use {
      "onsails/lspkind-nvim",
      ft = lsp_file_list
    }
    use {
      "glepnir/lspsaga.nvim",
      ft = lsp_file_list
    }
    -- if you could just sign right there
    use {
      "ray-x/lsp_signature.nvim",
      ft = lsp_file_list
    }
    -- How can it be? Great scott we have an lsp!!
    use {
      "neovim/nvim-lspconfig",
      after = {"lspsaga.nvim", "nvim-compe", "lspkind-nvim", "lsp_signature.nvim"},
      config = function()
        require("lsp")
      end
    }
    -- "...I am the captain now"
    use {
      "kabouzeid/nvim-lspinstall"
    }
    use {"hrsh7th/vim-vsnip", after = "nvim-lspconfig"}
    use {"hrsh7th/vim-vsnip-integ", after = "nvim-lspconfig"}
    use {"rafamadriz/friendly-snippets", after = "nvim-lspconfig"}
    --#endregion

    use "sainnhe/edge"
    -- plugin to the outlet
    use {"wbthomason/packer.nvim", opt = true}
    -- Oh hey its me
    use {
      "BenGH28/neo-runner.nvim",
      cmd = "NeoRunner",
      run = ":UpdateRemotePlugins"
    }
    -- I'm really liking this format
    use {
      "mhartington/formatter.nvim",
      ft = {"rust", "bash", "sh", "zsh", "lua", "cpp", "python", "markdown"},
      config = function()
        require("formatter-conf")
      end
    }
    -- colours to make unicorns vomit
    use {
      "nvim-treesitter/nvim-treesitter",
      event = "VimEnter",
      run = ":TSUpdate",
      config = function()
        require "treesitter-conf"
      end
    }
    -- quotes, brackets and easy times ahead
    use {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require "autopairs"
      end
    }
    -- which bracket is this again?
    use {
      "p00f/nvim-ts-rainbow",
      after = "nvim-treesitter",
      config = function()
        require "nvim-treesitter.configs".setup {
          rainbow = {enable = true}
        }
      end
    }
    -- I walk the line
    use {
      "glepnir/galaxyline.nvim",
      branch = "main"
    }
    -- files, files, files
    use {
      "kyazdani42/nvim-tree.lua",
      event = "VimEnter",
      config = function()
        require "tree-conf"
      end
    }
    -- see all the files on the moon
    use {
      "nvim-lua/telescope.nvim",
      event = "VimEnter",
      config = function()
        require "telescope-conf"
      end
    }
    -- jump around, jump around
    use {
      "phaazon/hop.nvim",
      event = "BufEnter",
      config = function()
        require "hop".setup {keys = "etovxqpdygfblzhckisuran", term_seq_bias = 1.5}
      end
    }
    -- the Lone Ranger
    use {
      "kevinhwang91/rnvimr",
      opt = true,
      branch = "main",
      config = function()
        vim.g.rnvimr_ex_enable = 1
      end
    }
    -- wait that hex code is a colour?
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end
    }
    -- I changed something didn't I?
    use {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup()
      end
    }
    -- lets git kraken... oh wait wrong git app
    use {
      "kdheepak/lazygit.nvim",
      event = "VimEnter",
      config = function()
        require "lazygit-conf"
      end
    }
    -- I'm pretty buff
    use {
      "akinsho/nvim-bufferline.lua",
      config = function()
        require "bufferline".setup()
      end
    }
    use {
      "henriquehbr/nvim-startup.lua",
      config = function()
        require "nvim-startup".setup {
          startup_file = "/tmp/nvim-startuptime",
          message = "startup time in ... {}"
        }
      end
    }

    -- comments are easy
    use {"tpope/vim-commentary"}
    -- 'I have you completely surrounded'
    use {"tpope/vim-surround"}
    -- do it again
    use "tpope/vim-repeat"
    -- start screen for the vimified
    use "mhinz/vim-startify"
    -- 360 no scope
    use "unblevable/quick-scope"
    -- what was that shortcut again?
    use "liuchengxu/vim-which-key"
    -- documentation for the enlightend
    use {"vim-scripts/DoxygenToolkit.vim", ft = {"cpp", "c"}}
    -- OCD and me
    use {
      "junegunn/vim-easy-align",
      opt = true
    }
  end
)

-- require("lsp")
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

-- =============================================================
--		Vim Mappings Only
-- =============================================================

-- alias the long function
local setmap = vim.api.nvim_set_keymap

local noremap = {noremap = true}
local silence = {noremap = true, silent = true}

setmap("i", "jk", "<ESC>", noremap)
setmap("i", "kj", "<ESC>", noremap)

setmap("n", "<Leader>ma", ":make<CR>", noremap)
setmap("n", "<Leader>mc", ":make clean<CR>", noremap)
setmap("n", "Y", "y$", noremap)
setmap("n", "0", "^", noremap)

-- substitute word under cursor
setmap("n", "<Leader>swg", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], noremap)
setmap("n", "<Leader>swl", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], noremap)

setmap("n", "<Leader>bn", ":bNext<CR>", silence)
setmap("n", "<Leader>bp", ":bprevious<CR>", silence)

setmap("n", "<Leader>.", ":tabn<CR>", silence)
setmap("n", "<Leader>,", ":tabp<CR>", silence)

-- set background quickly if I'm not using alacritty
setmap("n", "<Leader>al", ":set background=light<CR>", silence)
setmap("n", "<Leader>ad", ":set background=dark<CR>", silence)

-- alacritty themes
setmap("n", "<Leader>at", ":call MyFunctions#ToggleAlacrittyTheme()<CR>", silence)

-- windows
setmap("n", "<C-h>", ":wincmd h<CR>", silence)
setmap("n", "<C-j>", ":wincmd j<CR>", silence)
setmap("n", "<C-k>", ":wincmd k<CR>", silence)
setmap("n", "<C-l>", ":wincmd l<CR>", silence)
setmap("n", "<Leader>wo", ":on<CR>", silence)

-- resizing splits
setmap("n", "<Leader>wh", ":vertical resize -3<CR>", silence)
setmap("n", "<Leader>wj", ":resize -3<CR>", silence)
setmap("n", "<Leader>wk", ":resize +3<CR>", silence)
setmap("n", "<Leader>wl", ":vertical resize +3<CR>", silence)
setmap("n", "<Leader>w=", "<C-W>=", silence)

-- to do with files
setmap("n", "<Leader>fv", ":e $MYVIMRC<CR>", silence)
setmap("n", "<Leader>fj", ":w!<CR>", noremap)
setmap("n", "<Leader>fq", ":q", noremap)
setmap("n", "<Leader>v", ":luafile $MYVIMRC<CR>", noremap)

--Ctrl-Backspace will delete the word behind the cursor in --INSERT--
setmap("i", "<C-h>", "<C-O>b<C-O>dw", noremap)
