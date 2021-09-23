local lspinstall = require "lspinstall"

local function has_value(tab, val)
  for _, v in pairs(tab) do
    if v == val then
      return true
    end
  end
  return false
end

local M = {}
function M.auto_install_lsp()
  local desired_lsps = {"python", "lua", "cpp", "json", "yaml", "bash", "rust", "vim"}
  lspinstall.setup()
  local installed_servers = lspinstall.installed_servers()

  for _, lsp in pairs(desired_lsps) do
    -- install things
    if has_value(installed_servers, lsp) == false then
      lspinstall.install_server(lsp)
    end
  end
end

return M
