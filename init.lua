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

-- autocommands
opts = { clear = true }
local augroup = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd
local cmdline_highlights = augroup("cmdline-highlights", opts)
au("CmdlineLeave", {
  pattern = "*",
  command = "set nohlsearch",
  group = cmdline_highlights,
})
au("CmdlineEnter", {
  pattern = "*",
  command = "set hlsearch",
  group = cmdline_highlights,
})

local terminal_nums = augroup("terminal-numbers", opts)
au({ "TermOpen", "TermEnter" }, {
  pattern = "*",
  command = "setlocal nornu nonu",
  group = terminal_nums,
})

local tabstops = augroup("tabstops", opts)
au("BufEnter", {
  pattern = "*",
  callback = function()
    require("common").set_default_tab(vim.api.nvim_buf_get_option(0, "filetype"))
  end,
  group = tabstops,
})

local tex = augroup("tex", opts)
au("BufEnter", {
  pattern = "*.tex",
  command = "set ft=tex",
  group = tex,
})

local hl = vim.api.nvim_set_hl
-- "need this for lsp diagnostic virtual text
hl(0, "DiagnosticVirtualTextHint", { fg = "#10B981" })
hl(0, "DiagnosticVirtualTextWarning", { fg = "#e0af68" })
hl(0, "DiagnosticVirtualTextError", { fg = "#db4b4b" })
hl(0, "DiagnosticVirtualTextInformation", { fg = "#0db9d7" })

hl(0, "VirtualTextHint", { fg = "#10B981" })
hl(0, "VirtualTextWarning", { fg = "#e0af68" })
hl(0, "VirtualTextError", { fg = "#db4b4b" })
hl(0, "VirtualTextInformation", { fg = "#0db9d7" })
hl(0, "VirtualTextInfo", { fg = "#0db9d7" })
