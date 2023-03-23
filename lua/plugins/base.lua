return {
	-- better loading of files
	{
		"lewis6991/impatient.nvim",
		priority = 2000,
		lazy = false,
		config = function()
			require "impatient"
		end,
	},
	-- faster filetype
	{ "nathom/filetype.nvim", lazy = false },

	---[[General Dependencies
	{ "nvim-lua/popup.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	--]]
}
