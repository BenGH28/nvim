require "core.ide.lsp.vsnip"
require "core.ide.lsp.lspkind"
require "core.ide.lsp.lspsaga"
require "core.ide.lsp.null-ls"

-- local signature_config = require "core.ide.lsp.signature"
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
  },
}

local augroup = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

local function documentHighlight(client, bufnr)
  if not client.server_capabilities.documentHighlightProvider then
    vim.notify_once "not highlight provider"
    return
  end
  local hl = vim.api.nvim_set_hl
  hl(0, "LspDiagnosticsVirtualTextInformation", { bold = true, fg = "#51afef", bg = "#202328" })
  hl(0, "LspDiagnosticsVirtualTextWarning", { bold = true, fg = "#ecbe7b", bg = "#202328" })
  hl(0, "LspDiagnosticsVirtualTextHint", { bold = true, fg = "#98c379", bg = "#202328" })
  hl(0, "LspDiagnosticsVirtualTextError", { bold = true, fg = "#ec5f67", bg = "#202328" })

  local doc_highlight = augroup("lsp_document_highlight", {
    clear = false,
  })
  vim.api.nvim_clear_autocmds {
    buffer = bufnr,
    group = doc_highlight,
  }

  au({ "CursorHold", "CursorHoldI" }, {
    group = doc_highlight,
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })
  au({ "CursorMoved", "CursorMovedI" }, {
    group = doc_highlight,
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

local function format_on_save(bufnr)
  local format = augroup("format", { clear = true })
  vim.api.nvim_clear_autocmds {
    buffer = bufnr,
    group = format,
  }

  -- aha now we have format on save
  au("BufWritePre", {
    buffer = 0,
    callback = function()
      vim.lsp.buf.format { async = false }
    end,
    group = format,
  })
end

local function on_attach(client, bufnr)
  documentHighlight(client, bufnr)
  require("nvim-navic").attach(client, bufnr)
  format_on_save(bufnr)
end

local lua_settings = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = "LuaJIT",
      -- Setup your lua path
      path = vim.split(package.path, ";"),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { "vim", "awesome" },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
      },
    },
  },
}

local rust_opts = {
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<leader-dk>", require("rust-tools").hover_actions.hover_actions, { buffer = bufnr })
    end,
  },
  tools = {
    -- rust-tools options
    autoSetHints = true,
    inlay_hints = {
      only_current_line = false,
      show_parameter_hints = true,
    },
  },
}

local function my_setup()
  return {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

local function setup_servers()
  local servers = {
    "rust_analyzer",
    "bashls",
    "clangd",
    "html",
    "ltex",
    "jsonls",
    "pyright",
    "lua_ls",
    "tsserver",
    "gopls",
  }

  require("neodev").setup()
  require("mason").setup()
  require("mason-lspconfig").setup { ensure_installed = servers, automatic_installation = true }
  local installed = require("mason-lspconfig").get_installed_servers() or servers

  for _, server in pairs(installed) do
    local config = my_setup()
    if server == "lua_ls" then
      config.settings = lua_settings
    elseif server == "clangd" then
      -- get rid of the warnings from null-ls when using clangd
      config.capabilities.offsetEncoding = { "utf-16" }
    end

    if server == "rust_analyzer" then
      require("rust-tools").setup(rust_opts)
    else
      require("lspconfig")[server].setup(config)
    end
  end
end

setup_servers()
