require "core.ide.lsp.vsnip-conf"
require "core.ide.lsp.lspkind-conf"
require "core.ide.lsp.lspsaga-conf"
require "core.ide.lsp.null-ls-conf"

local signature_config = require "core.ide.lsp.signature"
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.diagnostic.config {
	virtual_text = {
		prefix = "●",
	},
}

local function documentHighlight(client, bufnr)
	if client.resolved_capabilities.document_highlight then
		vim.cmd [[
      hi! LspDiagnosticsVirtualTextInformation term=bold guifg='#51afef' guibg='#202328'
      hi! LspDiagnosticsVirtualTextWarning term=bold guifg='#ecbe7b' guibg='#202328'
      hi! LspDiagnosticsVirtualTextHint term=bold guifg='#98c379' guibg='#202328'
      hi! LspDiagnosticsVirtualTextError term=bold guifg='#ec5f67' guibg='#202328'
    ]]

		vim.api.nvim_create_augroup("lsp_document_highlight", {
			clear = false,
		})
		vim.api.nvim_clear_autocmds {
			buffer = bufnr,
			group = "lsp_document_highlight",
		}

		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

local function on_attach(client, bufnr)
	documentHighlight(client, bufnr)
	require("nvim-navic").attach(client, bufnr)
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
	tools = {
		-- rust-tools options
		autoSetHints = true,
		hover_with_actions = true,
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
	require("nvim-lsp-installer").setup()

	local servers = {
		"rust_analyzer",
		"bashls",
		"clangd",
		"html",
		"ltex",
		"jsonls",
		"pylsp",
		"sumneko_lua",
		"tsserver",
	}

	for _, server in pairs(servers) do
		local config = my_setup()
		if server == "sumneko_lua" then
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
