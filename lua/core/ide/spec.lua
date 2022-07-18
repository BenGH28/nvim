local spec = {
	{
		"neovim/nvim-lspconfig",
		config = function()
			require "core.ide.lsp"
		end,
		requires = {
			-- snippet fill
			{ "rafamadriz/friendly-snippets" },

			-- pictograms for the lsp
			{ "onsails/lspkind-nvim" },

			-- lsp front end that looks nice
			{ "tami5/lspsaga.nvim" },

			{
				"ray-x/lsp_signature.nvim",
				config = function()
					require "core.ide.lsp.signature"
				end,
			},

			-- convenient tool for installing lang servers
			{ "williamboman/nvim-lsp-installer" },

			-- rust ide stuff
			{ "simrat39/rust-tools.nvim" },

			-- add in some nice formatting and linting stuff
			{ "jose-elias-alvarez/null-ls.nvim" },

			-- get some snippet support
			{
				"hrsh7th/vim-vsnip",
				setup = function()
					vim.g.vsnip_snippet_dir = vim.fn.stdpath "config" .. "/vsnip"
				end,
			},
		},
	},

	-- diagnostics
	{ "folke/trouble.nvim" },

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
