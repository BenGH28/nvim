local spec = {

	{ "lewis6991/gitsigns.nvim" },

	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
	},

	{
		"APZelos/blamer.nvim",
		setup = function()
			vim.g.blamer_enabled = 1
		end,
	},
}
return spec
