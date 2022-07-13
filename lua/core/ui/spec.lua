local spec = {
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup {
				layout = {
					align = "center",
				},
			}
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup {
				buftype_exclude = { "terminal", "help", "startify", "nofile", "NvimTree" },
				filetype_exclude = { "help", "packer", "startify", "NvimTree", "alpha" },
			}
		end,
	},

	{
		"SmiteshP/nvim-navic",
		config = function()
			require("nvim-navic").setup {
				icons = {
					File = " ",
					Module = " ",
					Namespace = " ",
					Package = " ",
					Class = " ",
					Method = " ",
					Property = " ",
					Field = " ",
					Constructor = " ",
					Enum = "練",
					Interface = "練",
					Function = " ",
					Variable = " ",
					Constant = " ",
					String = " ",
					Number = " ",
					Boolean = "◩ ",
					Array = " ",
					Object = " ",
					Key = " ",
					Null = "ﳠ ",
					EnumMember = " ",
					Struct = " ",
					Event = " ",
					Operator = " ",
					TypeParameter = " ",
				},
				highlight = false,
				separator = " > ",
				depth_limit = 0,
				depth_limit_indicator = "..",
			}
		end,
	},
	-- todo comments that stand out
	{
		"folke/todo-comments.nvim",
		event = "BufEnter",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	},
	-- start screen for the vimified
	{ "mhinz/vim-startify", disable = true },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"akinsho/nvim-bufferline.lua",
		event = "UIEnter",
		config = function()
			require "core.ui.bufferline-conf"
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "UIEnter",
		config = function()
			require "core.ui.lualine-conf"
		end,
	},

	{
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		config = function()
			require "core.ui.tree-conf"
		end,
	},

	-- colorscheme
	{ "navarasu/onedark.nvim" },
}
return spec
