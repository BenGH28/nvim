local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

lspconfig.bashls.setup {
  filetypes = {'shell'},
  on_attach = on_attach,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.ccls.setup {
  filetypes = {'cpp', 'c'},
  on_attach = on_attach,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.yamlls.setup {
  filetypes = {'yaml'},
  on_attach = on_attach,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.pyls.setup {
  filetypes = {'python'},
  on_attach = on_attach,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.vimls.setup {
  filetypes = {'vim'},
  on_attach = on_attach,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.rls.setup {
  filetypes = {'rust'},
  on_attach = on_attach,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.jsonls.setup {
  on_attach = on_attach,
  filetypes = {'json'},
  settings = {rootMarkers = {'.git/'}}
}

lspconfig.efm.setup {
  init_options = {documentFormatting = true},
  filetypes = {"lua"},
  settings = {
    rootMarkers = {".git/"},
    languages = {
      lua = {
        {
          formatCommand = "lua-format -i --no-keep-simple-control-block-one-line --no-keep-simple-function-one-line --tab-width=2 --indent-width=2",
          formatStdin = true
        }
      }
    }
  }
}

---[[ lua
local user = vim.fn.expand('$USER')

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = '/home/' .. user .. '/.config/lua-language-server/'
local sumneko_binary = sumneko_root_path .. "bin/Linux/lua-language-server"

lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  filetypes = {'lua'},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
        }
      }
    }
  }
}
-- ]]
