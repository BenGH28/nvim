local spec = require "core.git.spec"
local use = require("packer").use

for _, plugin in ipairs(spec) do
	use(plugin)
end
