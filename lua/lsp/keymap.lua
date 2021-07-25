local setmap = vim.api.nvim_set_keymap
local silence = {noremap = true, silent = true}

setmap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", silence)
setmap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", silence)
setmap("n", "gr", ":lua vim.lsp.buf.references()<CR>", silence)
setmap("n", "gh", ':lua require"lspsaga.provider".lsp_finder()<CR>', silence)

-- "hover doc
setmap("n", "K", ':lua require"lspsaga.hover".render_hover_doc()<CR>', silence)
setmap("n", "C-j", ':lua require"lspsaga.provider".smart_scroll_with_saga(1)<CR>', silence)
setmap("n", "C-K", ':lua require"lspsaga.provider".smart_scroll_with_saga(-1)<CR>', silence)

-- "rename
setmap("n", "gn", ':lua require"lspsaga.rename".rename()<CR>', silence)
