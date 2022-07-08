local spec = require "core.ide.spec"
local use = require("core.pack").use_spec
-- load the plugin specification
use(spec)
-- now set up the lsp once the plugins set
require "core.ide.lsp"

-- require "core.ide.autopairs-conf"
-- require "core.ide.doxygen-conf"
-- require "core.ide.project-conf"
