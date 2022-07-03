local use = require("packer").use
local spec = require "core.lang.spec"

for _, plugin in ipairs(spec) do
	use(plugin)
end
