local pack = {}

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute "packadd packer.nvim"
end

local packer = require "packer"

-- these are all the prereqs plugins since you need packer to do any of the stuff in my config
-- these plugins should be loadeded here along side it
pack.pre_reqs = {
	-- better loading of files
	{
		"lewis6991/impatient.nvim",
		config = function()
			require "impatient"
		end,
	},
	-- faster filetype
	{ "nathom/filetype.nvim" },
	{ "wbthomason/packer.nvim" },

	---[[General Dependencies
	{ "nvim-lua/popup.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	--]]
}

function pack:startup(spec)
	spec = { spec } or { self.pre_reqs }
	packer.startup(spec)
end

return pack
