require("packer-config")
vim.cmd([[packadd packer.nvim]])
require("packer").startup(function(use)
	-- I feel the need, the need for speed
	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient")
		end,
	})

	--use better filetype
	use({
		"nathom/filetype.nvim",
		config = function()
			vim.g.did_load_filetypes = 1
		end,
	})

	---[[General Dependencies
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "kyazdani42/nvim-web-devicons" })
	--]]

	---[[ lsp
	--the next-gen completion engine
	use({ "hrsh7th/nvim-cmp" })

	-- complete based on the lsp
	use({ "hrsh7th/cmp-nvim-lsp" })

	-- get completion data for a given path
	use({ "hrsh7th/cmp-path" })

	-- get compeletion specific to the buffer
	use({ "hrsh7th/cmp-buffer" })

	-- completion base on the nvim api
	use({ "hrsh7th/cmp-nvim-lua" })

	-- tmux completion
	use({ "andersevenrud/cmp-tmux" })

	-- snippets
	use({
		"hrsh7th/vim-vsnip",
		config = function()
			vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/vsnip"
		end,
	})

	-- snippet run
	use({ "hrsh7th/cmp-vsnip" })

	-- snippet fill
	use({ "rafamadriz/friendly-snippets" })

	-- pictograms for the lsp
	use({ "onsails/lspkind-nvim" })

	-- lsp front end that looks nice
	use({
		"tami5/lspsaga.nvim",
	})

	-- if you could just sign right there
	use({ "ray-x/lsp_signature.nvim" })

	-- How can it be? Great scott we have an lsp!!
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("lsp")
		end,
	})

	-- "...I am the captain now"
	use({ "williamboman/nvim-lsp-installer" })

	-- lsp diagnostics make for a lot of trouble
	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({})
			local keymap = vim.api.nvim_set_keymap

			keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
		end,
	})
	--]] lsp

	-- colorscheme
	use("sainnhe/edge")

	-- plugin to the outlet
	use({ "wbthomason/packer.nvim", opt = true })

	-- Oh hey its me
	use({
		"BenGH28/neo-runner.nvim",
		cmd = "NeoRunner",
		run = ":UpdateRemotePlugins",
	})

	-- I'm really liking this format
	use({
		disable = true,
		"mhartington/formatter.nvim",
		config = function()
			require("formatter-conf")
		end,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls-conf")
		end,
	})

	-- colours to make unicorns vomit
	use({
		"nvim-treesitter/nvim-treesitter",
		event = "BufEnter",
		run = ":TSUpdate",
		config = function()
			require("treesitter-conf")
		end,
	})

	-- which bracket is this again?
	use({
		"p00f/nvim-ts-rainbow",
		after = "nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				rainbow = { enable = true },
			})
		end,
	})

	-- quotes, brackets and easy times ahead
	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("autopairs")
		end,
	})

	-- I walk the line
	use({
		disable = true,
		"glepnir/galaxyline.nvim",
		branch = "main",
	})

	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine-conf")
		end,
	})

	-- files, files, files
	use({
		"kyazdani42/nvim-tree.lua",
		event = "BufEnter",
		config = function()
			require("tree-conf")
		end,
	})

	-- see all the files on the moon
	use({
		"nvim-lua/telescope.nvim",
		event = "BufEnter",
		config = function()
			require("telescope-conf")
		end,
	})

	-- jump around, jump around
	use({
		"phaazon/hop.nvim",
		event = "BufEnter",
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran", term_seq_bias = 1.5 })
		end,
	})

	-- the Lone Ranger
	use({
		"kevinhwang91/rnvimr",
		opt = true,
		branch = "main",
		config = function()
			vim.g.rnvimr_ex_enable = 1
		end,
	})

	-- wait that hex code is a colour?
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- I changed something didn't I?
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- lets git kraken... oh wait wrong git app
	use({
		"kdheepak/lazygit.nvim",
		event = "BufEnter",
	})

	-- I'm pretty buff
	use({
		"akinsho/nvim-bufferline.lua",
		config = function()
			require("bufferline-conf")
		end,
	})

	-- comments are easy
	use({ "tpope/vim-commentary" })
	-- 'I have you completely surrounded'
	use({ "tpope/vim-surround" })
	-- do it again
	use("tpope/vim-repeat")
	-- start screen for the vimified
	use("mhinz/vim-startify")
	-- 360 no scope
	use("unblevable/quick-scope")
	-- documentation for the enlightend
	use({ "vim-scripts/DoxygenToolkit.vim", ft = { "cpp", "c" } })
	-- OCD and me
	use({
		"junegunn/vim-easy-align",
		opt = true,
	})
	use({
		"APZelos/blamer.nvim",
		config = function()
			vim.g.blamer_enabled = 1
		end,
	})

	--tmux syntax
	use({ "tmux-plugins/vim-tmux" })

	-- todo comments that stand out
	use({
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	})

	-- Session persistence
	use({
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		module = "persistence",
		config = function()
			require("persistence").setup()
		end,
	})

	-- Lua
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				layout = {
					align = "center",
				},
			})
		end,
	})
	use({
		"mfussenegger/nvim-dap",
		disable = true,
		config = function()
			vim.cmd([[
          nnoremap <silent> <F4> :lua require'dap'.repl.open()<CR>
          nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
          nnoremap <silent> <F9> :lua require'dap'.toggle_breakpoint()<CR>
          nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
          nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
          nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
          "nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
          "nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
          "nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
          "nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
       ]])
		end,
	})

	use({
		"Pocco81/DAPInstall.nvim",
		disable = true,
		config = function()
			local dap_install = require("dap-install")
			local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

			for _, debugger in ipairs(dbg_list) do
				dap_install.config(debugger)
			end
		end,
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				buftype_exclude = { "terminal", "help", "startify", "nofile", "NvimTree" },
				filetype_exclude = { "help", "packer", "startify", "NvimTree", "alpha" },
			})
		end,
	})
	use({ "lambdalisue/suda.vim" })
	use({ "moll/vim-bbye" })

	use({
		"SmiteshP/nvim-gps",
		config = function()
			require("nvim-gps").setup({
				icons = {
					["class-name"] = "ﴯ ",
					["function-name"] = " ",
					["method-name"] = " ",
					["container-name"] = "⛶ ",
					["tag-name"] = "炙",
				},
			})
		end,
	})
	use({ "simrat39/rust-tools.nvim" })
	-- Lua
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				-- Manual mode doesn't automatically change your root directory, so you have
				-- the option to manually do so using `:ProjectRoot` command.
				manual_mode = false,

				-- Methods of detecting the root directory. **"lsp"** uses the native neovim
				-- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
				-- order matters: if one is not detected, the other is used as fallback. You
				-- can also delete or rearangne the detection methods.
				detection_methods = { "lsp", "pattern" },

				-- All the patterns used to detect root dir, when **"pattern"** is in
				-- detection_methods
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Cargo.toml" },

				-- Table of lsp clients to ignore by name
				-- eg: { "efm", ... }
				ignore_lsp = {},

				-- Don't calculate root dir on specific directories
				-- Ex: { "~/.cargo/*", ... }
				exclude_dirs = {},

				-- Show hidden files in telescope
				show_hidden = false,

				-- When set to false, you will get a message when project.nvim changes your
				-- directory.
				silent_chdir = true,

				-- Path where project.nvim will store the project history for use in
				-- telescope
				datapath = vim.fn.stdpath("data"),
			})
			require("telescope").load_extension("projects")
		end,
	})

	use({
		"xuhdev/vim-latex-live-preview",
		ft = "tex",
		config = function()
			vim.g["livepreview_perviewer"] = "zathura"
		end,
	})
end)
