local spec = {

	{
		"nvim-treesitter/nvim-treesitter",
		before = "neorg",
		run = ":TSUpdate",
		requires = { "nvim-treesitter/playground", "windwp/nvim-ts-autotag", "p00f/nvim-ts-rainbow" },
	},
}

return spec
