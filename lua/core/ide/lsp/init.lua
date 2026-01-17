require("core.ide.lsp.vsnip")
require("core.ide.lsp.lspsaga")

vim.diagnostic.config({
  update_in_insert = true,
  signs = true,
  underline = true,
  virtual_text = {
    prefix = "●",
  },
})

local augroup = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == "ruff" then
      -- Disable hover in favour of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})

---@param client vim.lsp.Client
---@param bufnr integer
local function documentHighlight(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local hl = vim.api.nvim_set_hl
    hl(0, "LspDiagnosticsVirtualTextInformation", { bold = true, fg = "#51afef", bg = "#202328" })
    hl(0, "LspDiagnosticsVirtualTextWarning", { bold = true, fg = "#ecbe7b", bg = "#202328" })
    hl(0, "LspDiagnosticsVirtualTextHint", { bold = true, fg = "#98c379", bg = "#202328" })
    hl(0, "LspDiagnosticsVirtualTextError", { bold = true, fg = "#ec5f67", bg = "#202328" })

    local doc_highlight = augroup("lsp_document_highlight_" .. bufnr, {
      clear = true,
    })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = doc_highlight,
    })

    au({ "CursorHold", "CursorHoldI" }, {
      group = doc_highlight,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    au({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr,
      group = doc_highlight,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

local function format_on_save()
  local format = augroup("format", { clear = true })
  vim.api.nvim_clear_autocmds({
    pattern = "*",
    group = format,
  })

  -- aha now we have format on save
  au("BufWritePre", {
    pattern = "*",
    callback = function()
      if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
        vim.lsp.buf.format({ async = false })
      end
    end,
    group = format,
  })
end

local function on_attach(client, bufnr)
  documentHighlight(client, bufnr)
  format_on_save()
end

local function lua_settings()
  return {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  }
end

local function rust_opts()
  return {
    server = {
      on_attach = function(_, bufnr)
        vim.keymap.set(
          "n",
          "<leader-dk>",
          require("rust-tools").hover_actions.hover_actions,
          { buffer = bufnr }
        )
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
end

local function efm_settings()
  return {
    languages = {
      html = {
        {
          formatCommand = "prettier ${--tab-width:tabWidth} ${--single-quote:singleQuote} --parser html",
          formatStdin = true,
        },
      },
      sh = {
        { formatCommand = "shfmt -i 4 -ci -s -bn", formatStdin = true },
        { lintCommand = "shellcheck -",            lintStdin = true },
      },
      markdown = {
        { formatCommand = "mdformat -", formatStdin = true },
      },
      lua = {
        -- { formatCommand = "stylua -", formatStdin = true },
        { lintCommand = "selene -", lintStdin = true },
      },
    },
  }
end

local function setup_servers()
  local servers = {
    "bashls",
    "lua_ls",
    "efm",
  }

  require("neodev").setup()
  require("mason").setup()
  -- require("mason-lspconfig").setup { ensure_installed = servers, automatic_installation = true, automatic_enable = false }
  -- local installed = require("mason-lspconfig").get_installed_servers() or servers
  local installed = servers

  local function server_config()
    local client_capabilites = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require("cmp_nvim_lsp").default_capabilities(client_capabilites)
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end

  for _, server in pairs(installed) do
    local config = server_config()
    if server == "lua_ls" then
      config.settings = lua_settings()
    elseif server == "efm" then
      config.init_options = { documentFormatting = true }
      config.settings = efm_settings()
      config.filetypes = vim.tbl_keys(efm_settings().languages)
    elseif server == "pyright" then
      config.settings = {
        pyright = {
          -- Using Ruff's import organizer
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            diagnosticSeverityOverrides = {
              reportUndefinedVariable = "none",
            },
          },
        },
      }
    end

    vim.lsp.config(server, config)
    vim.lsp.enable(server)
  end
end

vim.keymap.set("n", "<leader>ldq", vim.diagnostic.setqflist, { desc = "diagnostics in quickfix list" })
setup_servers()
