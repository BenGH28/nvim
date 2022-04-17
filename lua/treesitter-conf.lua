local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

-- These two are optional and provide syntax highlighting
-- for Neorg tables and the @document.meta tag
parser_configs.norg_meta = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
		files = { "src/parser.c" },
		branch = "main",
	},
}

parser_configs.norg_table = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
		files = { "src/parser.c" },
		branch = "main",
	},
}

local opts = {
	ensure_installed = "maintained",
	ignore_install = { "latex" },
	sync_install = false,
	indent = { enable = true },
	highlight = { enable = true },

	-- plugin modules
	autotag = { enable = true },
	rainbow = { enable = true, extended_mode = true },
}

require("nvim-treesitter.configs").setup(opts)
