-- setting personal options
require "core.options"

-- lazy.nvim
require "mylazy"

require "cmd"
-- autocommands
require "autocmds"

local hl = vim.api.nvim_set_hl
-- "need this for lsp diagnostic virtual text
hl(0, "DiagnosticVirtualTextHint", { fg = "#10B981" })
hl(0, "DiagnosticVirtualTextWarning", { fg = "#e0af68" })
hl(0, "DiagnosticVirtualTextError", { fg = "#db4b4b" })
hl(0, "DiagnosticVirtualTextInformation", { fg = "#0db9d7" })

hl(0, "VirtualTextHint", { link = "DiagnosticVirtualTextHint" })
hl(0, "VirtualTextWarning", { link = "DiagnosticVirtualTextWarning" })
hl(0, "VirtualTextError", { link = "DiagnosticVirtualTextError" })
hl(0, "VirtualTextInformation", { link = "DiagnosticVirtualTextInformation" })
hl(0, "VirtualTextInfo", { link = "DiagnosticVirtualTextInformation" })

require "theme"
