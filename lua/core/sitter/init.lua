local spec = require "core.sitter.spec"
local use = require("packer").use

for _, plugin in ipairs(spec) do
	use(plugin)
end
