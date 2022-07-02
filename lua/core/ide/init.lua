local use = require("packer").use
local spec = {
	-- snippets
	{
		"hrsh7th/vim-vsnip",
		event = "InsertEnter",
		config = function()
			vim.g.vsnip_snippet_dir = vim.fn.stdpath "config" .. "/vsnip"
		end,
	},

	-- snippet fill
	{ "rafamadriz/friendly-snippets" },

	-- pictograms for the lsp
	{ "onsails/lspkind-nvim", before = "nvim-lspconfig" },

	-- lsp front end that looks nice
	{ "tami5/lspsaga.nvim", before = "nvim-lspconfig" },

	{ "ray-x/lsp_signature.nvim", before = "nvim-lspconfig" },

	{ "williamboman/nvim-lsp-installer", before = "nvim-lspconfig" },

	{ "neovim/nvim-lspconfig" },

	-- diagnostics
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup {}
			local keymap = vim.api.nvim_set_keymap

			keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
		end,
	},

	{ "jose-elias-alvarez/null-ls.nvim" },
}

for _, plugin in ipairs(spec) do
	use(plugin)
end
