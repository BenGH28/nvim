local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  else
    print("no highlight")
  end
end

lspconfig.bashls.setup {
  filetypes = {'shell'},
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.ccls.setup {
  filetypes = {'cpp', 'c'},
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    compilationDatabaseDirectory = "build",
    index = {threads = 0},
    clang = {excludeArgs = {"-frounding-math"}}
  },
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.yamlls.setup {
  filetypes = {'yaml'},
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.pyls.setup {
  filetypes = {'python'},
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.vimls.setup {
  filetypes = {'vim'},
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.rls.setup {
  filetypes = {'rust'},
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {'json'},
  settings = {rootMarkers = {'.git/'}}
}

---[[ efm

local luaFormat = {
  formatCommand = "lua-format -i --no-keep-simple-control-block-one-line --no-keep-simple-function-one-line --tab-width=2 --indent-width=2",
  formatStdin = true
}

local vint = {lintCommand = 'vint -', formatStdin = true}

-- local flake8 = {
--   lintCommand = "flake8 --max-line-length 160 --stdin-display-name ${INPUT} -",
--   lintIgnoreExitCode = true,
--   lintStdin = true,
--   lintFormats = {"%f:%l:%c: %m"}
-- }
-- local autopep8 = {formatCommand = 'autopep8 -', formatStdin = true}
-- local isort = {formatCommand = 'isort --queit -', formatStdin = true}
lspconfig.efm.setup {
  capabilities = capabilities,
  init_options = {documentFormatting = true},
  filetypes = {"lua", "python", "vim", 'cpp', 'c'},
  settings = {languages = {lua = {luaFormat}, vim = {vint}}}
}

-- ]]

---[[ lua
local user = vim.fn.expand('$USER')

-- set the path to the sumneko installation
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
