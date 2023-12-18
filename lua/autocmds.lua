-- autocommands
local opts = { clear = true }
local augroup = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

local ignition = augroup("ignition", opts)
au("LspAttach", {
  pattern = "code.py",
  group = ignition,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name == "pyright" then
      -- update the python interpreter path once pyright loads
      vim.defer_fn(function()
        vim.cmd [[PyrightSetPythonPath C:\\Python27\\python.exe]]
      end, 10)
    end
  end,
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

local norg_readme = augroup("norg-readme", opts)
au("BufWritePost", {
  pattern = "README.norg",
  callback = function()
    vim.cmd [[Neorg export to-file README.md markdown]]
  end,
  group = norg_readme,
})

local relative_numbers = augroup("relative-numbers", opts)
au("InsertEnter", {
  pattern = "*",
  command = "set norelativenumber",
  group = relative_numbers,
})
au("InsertLeave", {
  pattern = "*",
  command = "set relativenumber",
  group = relative_numbers,
})
