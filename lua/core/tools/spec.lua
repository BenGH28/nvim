local spec = {
	{
		"BenGH28/neo-runner.nvim",
		cmd = "NeoRunner",
		run = ":UpdateRemotePlugins",
	},

	{ "lambdalisue/suda.vim" },

	{ "moll/vim-bbye" },

	{
		"phaazon/hop.nvim",
		event = "BufEnter",
		keys = { "gl", "gp" },
		config = function()
			require("hop").setup { keys = "etovxqpdygfblzhckisuran", term_seq_bias = 1.5 }
		end,
	},
	{
		"nvim-lua/telescope.nvim",
		event = "UIEnter",
		config = function()
			require "core.tools.telescope-conf"
		end,
	},

	-- tpope
	{ "tpope/vim-commentary" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },

	{ "unblevable/quick-scope" },
}

return spec
