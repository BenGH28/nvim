require "lsp.keymap"
require "lsp.vsnip-conf"
require "lsp.cmp-conf"
require "lsp.lspkind-conf"
require "lsp.lspsaga-conf"

local signature_config = require "lsp.signature"
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

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

local function on_attach(client, bufnr)
  documentHighlight(client, bufnr)
  require "lsp_signature".on_attach(signature_config)
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
    on_attach = on_attach
  }
end

local function setup_servers()
  local lspinstaller = require "nvim-lsp-installer"
  lspinstaller.on_server_ready(
    function(server)
      local config = my_setup()
      if server.name == "lua" then
        config.settings = lua_settings
      end
      server:setup(config)
    end
  )
end

setup_servers()
