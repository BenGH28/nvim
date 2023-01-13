return {
	{
		"rcarriga/nvim-notify",
		lazy = false,
		config = function()
			require("notify").setup {
				background_color = "#282c34",
				fps = 30,
				icons = {
					DEBUG = "",
					ERROR = "",
					INFO = "",
					TRACE = "✎",
					WARN = "",
				},
				level = 2,
				minimum_width = 50,
				render = "simple",
				stages = "static",
				timeout = 5000,
				top_down = true,
			}
			vim.notify = require "notify"
		end,
	},

	{ "lambdalisue/suda.vim", cmd = { "SudaRead", "SudaWrite" } },

	{ "moll/vim-bbye", cmd = "Bdelete" },

	{
		"phaazon/hop.nvim",
		cmd = { "HopLine", "HopPattern", "HopWord" },
		config = function()
			require("hop").setup { keys = "etovxqpdygfblzhckisuran", term_seq_bias = 1.5 }
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = function()
			require "core.telescope"
		end,
		dependencies = {
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{
				"ahmedkhalf/project.nvim",
				config = function()
					require "core.project"
				end,
			},
		},
	},

	-- tpope
	{ "tpope/vim-commentary", event = "BufEnter" },
	{ "tpope/vim-surround", event = "BufEnter" },
	{ "tpope/vim-repeat", event = "BufEnter" },

	{
		"unblevable/quick-scope",
		event = "VeryLazy",
		init = function()
			vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
			vim.g.qs_max_chars = 150
			vim.cmd [[highlight QuickScopePrimary guifg='#61afe0' gui=underline ctermfg=155 cterm=underline]]
			vim.cmd [[highlight QuickScopeSecondary guifg='#98d379' gui=underline ctermfg=81 cterm=underline]]
		end,
	},
}
