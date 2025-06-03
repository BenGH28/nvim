-- autocommands
local opts = { clear = true }
local augroup = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

local trim_whitespace = augroup("trim-whitespace", opts)
au("BufWritePre", {
  pattern = "*",
  command = "TrimSpace",
  group = trim_whitespace
})

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

local systemd_units = augroup("systemd-units", opts)
au("BufEnter", {
  pattern = "*.service",
  command = "set ft=ini",
  group = systemd_units,
})

local sql_comments = augroup("sql-comments", opts)
au("Filetype", {
  pattern = "*sql",
  command = "set commentstring=--%s",
  group = sql_comments,
})


local hi_yank = augroup("highlights-yank", opts)
au("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual', timeout = 300 }
  end,
  group = hi_yank,
})
