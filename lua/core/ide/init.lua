local spec = require "core.ide.spec"
local use = require("packer").use

-- let packer manage the IDE spec
for _, plugin in ipairs(spec) do
	use(plugin)
end

-- now set up the lsp once the plugins set
require "core.ide.lsp"
