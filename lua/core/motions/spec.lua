local spec = {
	{
		"phaazon/hop.nvim",
		event = "BufEnter",
		config = function()
			require("hop").setup { keys = "etovxqpdygfblzhckisuran", term_seq_bias = 1.5 }
		end,
	},

	-- tpope
	{ "tpope/vim-commentary" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },

	{ "unblevable/quick-scope" },
}

return spec
