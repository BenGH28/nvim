local installed_servers = require "nvim-lsp-installer.servers"

local M = {}
function M.auto_install_lsp()
  local servers = {"pylsp", "sumneko_lua", "clangd", "jsonls", "yamlls", "bashls", "rust_analyzer", "vimls"}
  for _, server in pairs(servers) do
    local server_available, requested_server = installed_servers.get_server(server)
    if server_available then
      if not requested_server:is_installed() then
        -- Queue the server to be installed
        requested_server:install()
      end
    end
  end
end

return M
