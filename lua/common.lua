local cmd = vim.api.nvim_command
local M = {}

function M.set_default_tab(filetype)
	-- get the ftplugin directory path
	local ftplugin = vim.fn.stdpath "config" .. "/ftplugin/"
	local filename = filetype .. ".lua"

	-- get the ftplugin file from the directory
	local file = vim.fn.globpath(ftplugin, filename)
	-- no ftplugin so lets set a tabwidth
	if file == "" then
		vim.bo.shiftwidth = 4
		vim.bo.tabstop = 4
	end
end

function M.edit_lua_file(file)
	local path = vim.fn.stdpath "config" .. "/lua/" .. file .. ".lua"
	cmd("edit " .. path)
end

-- @param file must hand in the extension
function M.edit_plugin_file(file)
	local path = vim.fn.stdpath "config" .. "/plugin/" .. file
	cmd("edit " .. path)
end

local function source_file(file)
	local path = vim.fn.stdpath "config" .. "/lua/" .. file .. ".lua"
	cmd("source " .. path)
end

local function reload()
	for pkg in pairs(package.loaded) do
		if pkg:match "^core.*" then
			package.loaded[pkg] = nil
			-- print("unloading package %s", pkg)
		end
	end
	source_file "core/init"
end

function M.install_plugins()
	reload()
	cmd "PackerInstall"
end

function M.update_plugins()
	reload()
	cmd "PackerUpdate"
end

function M.clean_plugins()
	reload()
	cmd "PackerClean"
end

function M.compile_plugins()
	reload()
	cmd "PackerCompile"
end

function M.sync_plugins()
	reload()
	cmd "PackerSync"
end

function M.packer_status()
	reload()
	cmd "PackerStatus"
end

return M
