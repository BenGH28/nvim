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
  vim.cmd("edit " .. path)
end

-- @param file must hand in the extension
function M.edit_plugin_file(file)
  local path = vim.fn.stdpath "config" .. "/plugin/" .. file
  vim.cmd("edit " .. path)
end

function M.scratch_buffer_below()
  vim.api.nvim_command "new"
  vim.opt_local.buftype = "nofile"
  vim.opt_local.bufhidden = "hide"
  vim.opt_local.swapfile = false
  vim.cmd "file scratch"
end

return M
