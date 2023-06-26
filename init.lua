local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	defaults = {
		lazy = true,
	},
}
-- setting my personal options
require "core.options"

-- loading my plugins
require("lazy").setup("plugins", opts)

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
