local lspinstall = require "lspinstall"
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local setmap = vim.api.nvim_set_keymap
local silence = {noremap = true, silent = true}

setmap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", silence)
setmap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", silence)
setmap("n", "gr", ":lua vim.lsp.buf.references()<CR>", silence)
setmap("n", "gh", ':lua require"lspsaga.provider".lsp_finder()<CR>', silence)

-- "hover doc
setmap("n", "K", ':lua require"lspsaga.hover".render_hover_doc()<CR>', silence)
setmap("n", "C-j", ':lua require"lspsaga.provider".smart_scroll_with_saga(1)<CR>', silence)
setmap("n", "C-K", ':lua require"lspsaga.provider".smart_scroll_with_saga(-1)<CR>', silence)

-- "rename
setmap("n", "gn", ':lua require"lspsaga.rename".rename()<CR>', silence)

local function documentHighlight(client, bufnr)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      hi LspDiagnosticsVirtualTextInformation term=bold guifg='#51afef' guibg='#202328'
      hi LspDiagnosticsVirtualTextWarning term=bold guifg='#ecbe7b' guibg='#202328'
      hi LspDiagnosticsVirtualTextHint term=bold guifg='#98c379' guibg='#202328'
      hi LspDiagnosticsVirtualTextError term=bold guifg='#ec5f67' guibg='#202328'
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local lua_settings = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = "LuaJIT",
      -- Setup your lua path
      path = vim.split(package.path, ";")
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {"vim"}
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
      }
    }
  }
}

local function my_setup()
  return {
    capabilities = capabilities,
    on_attach = documentHighlight
  }
end

local function has_value(tab, val)
  for _, v in pairs(tab) do
    if v == val then
      return true
    end
  end
  return false
end

local function auto_install_lsp()
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

local function setup_servers()
  require "lspinstall".setup()
  local servers = require "lspinstall".installed_servers()

  for _, server in pairs(servers) do
    local config = my_setup()
    if server == "lua" then
      config.settings = lua_settings
    end
    require "lspconfig"[server].setup(config)
  end
end

auto_install_lsp()
setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require "lspinstall".post_install_hook = function()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
