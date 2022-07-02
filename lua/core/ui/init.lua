local spec = require "core.ui.spec"
local use = require("packer").use

for _, plugin in ipairs(spec) do
	use(plugin)
end
