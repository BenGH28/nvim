local use = require("packer").use
local spec = require "core.completion.spec"

for _, plugin in ipairs(spec) do
	use(plugin)
end
