local M = {}

function M.set_default_tab(filetype)
	--get the ftplugin directory path
	local ftplugin = vim.fn.stdpath("config") .. "/ftplugin/"
	local filename = filetype .. ".lua"

	--get the ftplugin file from the directory
	local file = vim.fn.globpath(ftplugin, filename)
	if file == "" then
		vim.bo.shiftwidth = 4
		vim.bo.tabstop = 4
	else
		print(file)
	end
end

return M
