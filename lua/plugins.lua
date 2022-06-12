require("packer-config")
require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })
	-- better loading of files
	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient")
		end,
	})

	--use faster filetype
	use({ "nathom/filetype.nvim" })

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

	-- cmdline completion
	use({ "hrsh7th/cmp-cmdline" })

	-- tmux completion
	use({ "andersevenrud/cmp-tmux" })

	-- sort python dunder methods below regular methods
	use("lukas-reineke/cmp-under-comparator")

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
	use({ "onsails/lspkind-nvim", before = "nvim-lspconfig" })

	-- lsp front end that looks nice
	use({ "tami5/lspsaga.nvim", before = "nvim-lspconfig" })

	use({ "ray-x/lsp_signature.nvim", before = "nvim-lspconfig" })

	use({ "williamboman/nvim-lsp-installer", before = "nvim-lspconfig" })

	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("lsp-conf")
		end,
	})

	-- diagnostics
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

	use({
		"BenGH28/neo-runner.nvim",
		cmd = "NeoRunner",
		run = ":UpdateRemotePlugins",
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls-conf")
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		before = "neorg",
		event = "BufEnter",
		run = ":TSUpdate",
		config = function()
			require("treesitter-conf")
		end,
	})

	use({
		"p00f/nvim-ts-rainbow",
		before = "nvim-treesitter",
	})

	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("autopairs")
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine-conf")
		end,
	})

	use({
		"kyazdani42/nvim-tree.lua",
		event = "BufEnter",
		config = function()
			require("tree-conf")
		end,
	})

	use({
		"nvim-lua/telescope.nvim",
		event = "BufEnter",
		config = function()
			require("telescope-conf")
		end,
	})

	use({
		"phaazon/hop.nvim",
		event = "BufEnter",
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran", term_seq_bias = 1.5 })
		end,
	})

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	use({
		"kdheepak/lazygit.nvim",
		event = "BufEnter",
	})

	use({
		"akinsho/nvim-bufferline.lua",
		config = function()
			require("bufferline-conf")
		end,
	})

	-- tpope
	use({ "tpope/vim-commentary" })
	use({ "tpope/vim-surround" })
	use("tpope/vim-repeat")

	-- start screen for the vimified
	use("mhinz/vim-startify")
	use("unblevable/quick-scope")
	use({ "vim-scripts/DoxygenToolkit.vim", ft = { "cpp", "c", "javascript" } })
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
		requires = "nvim-lua/plenary.nvim",
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
		-- disable = true,
		after = "nvim-treesitter",
		before = "nvim-lualine",
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
	use({ "simrat39/rust-tools.nvim", disable = false, before = "nvim-lspconfig" })
	-- Lua
	use({
		"ahmedkhalf/project.nvim",
		event = "BufEnter",
		requires = { "nvim-lua/telescope.nvim" },
		config = function()
			require("project-conf")
		end,
	})
	use({
		"xuhdev/vim-latex-live-preview",
		ft = "tex",
		setup = function()
			--run this before we load
			vim.g["livepreview_previewer"] = "okular"
		end,
	})
	use({ "davidgranstrom/nvim-markdown-preview" })

	use({ "windwp/nvim-ts-autotag", before = "nvim-treesitter" })

	use({
		"nvim-neorg/neorg",
		ft = "norg",
		config = function()
			require("norg-conf")
		end,
		requires = "nvim-lua/plenary.nvim",
	})
	use("fladson/vim-kitty")
end)
