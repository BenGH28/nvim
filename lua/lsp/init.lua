local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

local function documentHighlight(client, bufnr)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspDiagnosticsVirtualTextInformation term=bold guifg='#51afef' guibg='#202328'
      hi LspDiagnosticsVirtualTextWarning term=bold guifg='#ecbe7b' guibg='#202328'
      hi LspDiagnosticsVirtualTextHint term=bold guifg='#98c379' guibg='#202328'
      hi LspDiagnosticsVirtualTextError term=bold guifg='#ec5f67' guibg='#202328'
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

lspconfig.bashls.setup {
  capabilities = capabilities,
  on_attach = documentHighlight,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.clangd.setup {
  capabilities = capabilities,
  on_attach = documentHighlight,
}
lspconfig.html.setup {
  on_attach = documentHighlight,
  capabilities = capabilities
}
lspconfig.yamlls.setup {
  filetypes = {'yaml'},
  capabilities = capabilities,
  on_attach = documentHighlight,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.pyls.setup {
  filetypes = {'python'},
  on_attach = documentHighlight,
  capabilities = capabilities,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.vimls.setup {
  filetypes = {'vim'},
  on_attach = documentHighlight,
  capabilities = capabilities,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.rls.setup {
  filetypes = {'rust'},
  on_attach = documentHighlight,
  capabilities = capabilities,
  settings = {rootMarkers = {'.git/'}}
}
lspconfig.jsonls.setup {
  capabilities = capabilities,
  on_attach = documentHighlight,
  filetypes = {'json'},
  settings = {rootMarkers = {'.git/'}}
}

---[[ efm

local luaFormat = {
  formatCommand = "lua-format -i --no-keep-simple-control-block-one-line --no-keep-simple-function-one-line --tab-width=2 --indent-width=2",
  formatStdin = true
}

local vint = {lintCommand = 'vint -', lintStdin = true}

local shfmt = {formatCommand = 'shfmt -ci -i 4 -s -bn', formatStdin = true}

local html = {
  formatCommand = './node_modules/prettier ${--tab-width:tabWidth} ${--single-quote:singleQuote} --parser html'
}
local shellcheck = {
  lintCommand = 'shellcheck -f gcc -x',
  lintSource = 'shellcheck',
  lintStdin = true
}
lspconfig.efm.setup {
  capabilities = capabilities,
  init_options = {
    documentFormatting = true,
    hover = true,
    documentSymbol = true,
    codeAction = true,
    completion = true
  },
  filetypes = {"lua", "python", "vim", 'cpp', 'c', 'sh', 'shell', 'zsh', 'html'},
  settings = {
    languages = {
      lua = {luaFormat},
      vim = {vint},
      sh = {shfmt, shellcheck},
      html = {html}
    }
  }
}

-- ]]

---[[ lua
local user = vim.fn.expand('$USER')

-- set the path to the sumneko installation
local sumneko_root_path = '/home/' .. user .. '/.config/lua-language-server/'
local sumneko_binary = sumneko_root_path .. "bin/Linux/lua-language-server"

lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  on_attach = documentHighlight,
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
