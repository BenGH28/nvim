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
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})

---@param client vim.lsp.Client
---@param bufnr integer
local function documentHighlight(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local doc_highlight = augroup("lsp_document_highlight_" .. bufnr, { clear = true })
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

au("BufWritePre", {
  pattern = "*",
  group = augroup("format", { clear = true }),
  callback = function()
    if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
      vim.lsp.buf.format({ async = false })
    end
  end,
})

local function on_attach(client, bufnr)
  documentHighlight(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

local function lua_settings()
  return {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      hint = {
        enable = true,
        setType = true,
        paramType = true,
        paramName = "All",
        arrayIndex = "Enable",
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
    "basedpyright",
  }

  require("neodev").setup()
  require("mason").setup()
  require("mason-lspconfig").setup { ensure_installed = servers, automatic_installation = true, automatic_enable = false }
  local installed = require("mason-lspconfig").get_installed_servers() or servers

  local client_capabilities = vim.lsp.protocol.make_client_capabilities()
  local capabilities = require("cmp_nvim_lsp").default_capabilities(client_capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  for _, server in pairs(installed) do
    local config = {
      capabilities = capabilities,
      on_attach = on_attach,
    }
    if server == "lua_ls" then
      config.settings = lua_settings()
    elseif server == "efm" then
      local efm = efm_settings()
      config.init_options = { documentFormatting = true }
      config.settings = efm
      config.filetypes = vim.tbl_keys(efm.languages)
    elseif server == "basedpyright" then
      config.settings = {
        basedpyright = {
          disableOrganizeImports = true,
          analysis = {
            diagnosticSeverityOverrides = {
              reportMissingModuleSource       = "none",
              reportUnknownMemberType         = "none", -- Jython dynamic types
              reportUnknownVariableType       = "none",
              reportUnknownArgumentType       = "none",
              reportTypeCommentUsage          = "none", -- Python 2 type comments used in Ignition/Jython
              reportUnannotatedClassAttribute = "none",
              reportImplicitOverride          = "none",
              reportMissingTypeStubs          = "none",
              reportUnknownParameterType      = "none",
              reportUnusedCallResult          = "none",
              reportInvalidAbstractMethod     = "none",
              reportUnknownLambdaType         = "none",
              reportUndefinedVariable         = "none", -- Jython/Ignition runtime-injected names (replaces # noqa: F821)
              reportAny                       = "none",
            },
            inlayHints = {
              variableTypes = true,
              functionReturnTypes = true,
              callArgumentNames = true,
              genericTypes = false,
            },
          },
        },
      }
    end

    vim.lsp.config(server, config)
    vim.lsp.enable(server)
  end
end

vim.keymap.set("n", "<leader>lyo", function()
  require("symbol_outline").toggle()
end, { desc = "symbol outline" })
vim.keymap.set("n", "<leader>ldq", vim.diagnostic.setqflist, { desc = "diagnostics in quickfix list" })
setup_servers()
