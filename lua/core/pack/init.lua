-- get packer installed
require "core.pack.packer-config"

--plugin specification
local spec = function(use)
	use { "wbthomason/packer.nvim" }
	-- better loading of files
	use {
		"lewis6991/impatient.nvim",
		config = function()
			require "impatient"
		end,
	}

	--use faster filetype
	use { "nathom/filetype.nvim" }

	---[[General Dependencies
	use { "nvim-lua/popup.nvim" }
	use { "nvim-lua/plenary.nvim" }
	use { "kyazdani42/nvim-web-devicons" }
	--]]

	-- colorscheme
	use "sainnhe/edge"
	use "marko-cerovac/material.nvim"

	use {
		"BenGH28/neo-runner.nvim",
		cmd = "NeoRunner",
		run = ":UpdateRemotePlugins",
	}

	--tmux syntax
	use { "tmux-plugins/vim-tmux" }

	use { "lambdalisue/suda.vim" }

	use { "moll/vim-bbye" }

	use {
		"xuhdev/vim-latex-live-preview",
		ft = "tex",
		setup = function()
			--run this before we load
			vim.g["livepreview_previewer"] = "okular"
		end,
	}
	use { "davidgranstrom/nvim-markdown-preview" }

	use {
		"nvim-neorg/neorg",
		ft = "norg",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require "core.conf.norg-conf"
		end,
	}
	use "fladson/vim-kitty"
end

require("packer").startup(spec)
