local spec = {
	-- snippets
	{
		"hrsh7th/vim-vsnip",
		event = "InsertEnter",
		setup = function()
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
	{ "folke/trouble.nvim" },

	{ "jose-elias-alvarez/null-ls.nvim" },

	{ "simrat39/rust-tools.nvim", disable = false, before = "nvim-lspconfig" },

	{
		"ahmedkhalf/project.nvim",
		event = "BufEnter",
		requires = { "nvim-lua/telescope.nvim" },
		config = function()
			require "core.ide.project-conf"
		end,
	},

	{
		"mfussenegger/nvim-dap",
		disable = true,
	},

	{
		"vim-scripts/DoxygenToolkit.vim",
		ft = { "cpp", "c", "javascript" },
		config = function()
			require "core.ide.doxygen-conf"
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require "core.ide.autopairs-conf"
		end,
	},
	-- Session persistence
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		module = "persistence",
		config = function()
			require("persistence").setup()
		end,
	},
}

return spec
