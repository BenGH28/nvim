local spec = {
	{ "windwp/nvim-ts-autotag", before = "nvim-treesitter" },

	{
		"p00f/nvim-ts-rainbow",
		before = "nvim-treesitter",
	},

	{
		"nvim-treesitter/nvim-treesitter",
		before = "neorg",
		run = ":TSUpdate",
		requires = "nvim-treesitter/playground",
	},
}

return spec
