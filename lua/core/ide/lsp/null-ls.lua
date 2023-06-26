local null_ls = require "null-ls"

-- register any number of sources simultaneously
local sources = {
	-- null_ls.builtins.formatting.prettier,
	null_ls.builtins.formatting.stylua,
	-- null_ls.builtins.formatting.clang_format,
	-- null_ls.builtins.formatting.rustfmt,
	null_ls.builtins.formatting.shfmt,
	-- null_ls.builtins.diagnostics.write_good,
	null_ls.builtins.diagnostics.cppcheck,
	null_ls.builtins.diagnostics.vint,
	null_ls.builtins.diagnostics.yamllint,
}

null_ls.setup { sources = sources }
