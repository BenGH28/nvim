local spec = {

	{ "lewis6991/gitsigns.nvim", event = "BufEnter" },

	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
	},

	{
		"APZelos/blamer.nvim",
		event = "BufEnter",
		setup = function()
			vim.g.blamer_enabled = 1
		end,
	},
}
return spec
