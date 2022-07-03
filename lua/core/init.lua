-- set up packer so we can install plugins
require("core.pack").init()

-- load me some modules
require "core.completion"
require "core.ide"
require "core.sitter"
require "core.git"
require "core.motions"
require "core.ui"
require "core.lang"
require "core.tools"

require "core.conf"
