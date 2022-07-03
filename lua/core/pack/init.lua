local pack = {}
local packer = require "packer"

pack.use_spec = function(plugins)
	for _, plugin in ipairs(plugins) do
		packer.use(plugin)
	end
end

local function use_prereqs()
	-- these are all the prereqs plugins
	-- since you need packer to do any of the stuff in my config
	-- these plugins should be loadeded here along side it
	local spec = {
		-- better loading of files
		{
			"lewis6991/impatient.nvim",
			config = function()
				require "impatient"
			end,
		},

		{ "wbthomason/packer.nvim" },

		-- faster filetype
		{ "nathom/filetype.nvim" },

		---[[General Dependencies
		{ "nvim-lua/popup.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{ "kyazdani42/nvim-web-devicons" },

		--]]
	}
	pack.use_spec(spec)
end

-- get packer ready for the plugins
function pack.init(config)
	require "core.pack.packer-setup"
	local packer_config = config or {}
	-- make packer work correctly from the get go
	packer.init(packer_config)
	--clear the packer specification and plugins list
	packer.reset()
	use_prereqs()
end

return pack
