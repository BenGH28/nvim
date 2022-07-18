local spec = {

	{
		"nvim-treesitter/nvim-treesitter",
		before = "neorg",
		event = "UIEnter",
		run = ":TSUpdate",
		requires = {
			"nvim-treesitter/playground",
			"windwp/nvim-ts-autotag",
			"p00f/nvim-ts-rainbow",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require "core.sitter.treesitter-conf"
		end,
	},
}

return spec
