local spec = require "core.motions.spec"
local use = require("packer").use

for _, plugin in ipairs(spec) do
	use(plugin)
end
