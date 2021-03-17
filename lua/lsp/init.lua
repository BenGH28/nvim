lspconfig = require('lspconfig')

lspconfig.bashls.setup {
  filetypes = {'shell'},
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.ccls.setup {
  filetypes = {'cpp', 'c'},
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.yamlls.setup {
  filetypes = {'yaml'},
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.pyls.setup {
  filetypes = {'python'},
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.vimls.setup {
  filetypes = {'vim'},
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.rls.setup {filetypes = {'rust'}, settings = {rootMarkers = {'.git/'}}}
lspconfig.jsonls.setup {
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
