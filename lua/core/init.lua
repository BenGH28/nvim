-- don't load these things
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

local pack = require "core.pack"

--load me some modules
local modules = {
	require "core.completion",
	require "core.ide",
	require "core.sitter",
	require "core.git",
	require "core.ui",
	require "core.lang",
	require "core.tools",
	pack.pre_reqs,
}

local plugins = {}
for _, module in pairs(modules) do
	for _, plugin in pairs(module) do
		table.insert(plugins, plugin)
	end
end

pack.startup(plugins)

require "options"
