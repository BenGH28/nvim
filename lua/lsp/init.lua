require("lsp.keymap")
require("lsp.vsnip-conf")
require("lsp.cmp-conf")
require("lsp.lspkind-conf")
require("lsp.lspsaga-conf")

local signature_config = require("lsp.signature")
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
})

local function documentHighlight(client, bufnr)
	if client.resolved_capabilities.document_highlight then
		vim.cmd
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
      ]]
	end
end

local function on_attach(client, bufnr)
	documentHighlight(client, bufnr)
	require("lsp_signature").on_attach(signature_config)
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
			globals = { "vim" },
		},
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
			},
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
	local lspinstaller = require("nvim-lsp-installer")

	lspinstaller.on_server_ready(function(server)
		local config = my_setup()
		if server.name == "sumneko_lua" then
			config.settings = lua_settings
		elseif server.name == "rust_analyzer" then
			local server_opts = {}
			local tools_opts = require("lsp.rust-tools-opts").tools
			local dap_opts = require("lsp.rust-tools-opts").dap
			require("rust-tools").setup({
				-- The "server" property provided in rust-tools setup function are the
				-- settings rust-tools will provide to lspconfig during init.            --
				-- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
				-- with the user's own settings (opts).
				tools = tools_opts,
				server = vim.tbl_deep_extend("force", server:get_default_options(), server_opts),
				dap = dap_opts,
			})
			server:attach_buffers()
			return
		end
		server:setup(config)
	end)
end

setup_servers()
