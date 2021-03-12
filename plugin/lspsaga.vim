"lsp provider to find the cursor word definition and reference
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>

"code actions
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca <cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>

"hover doc
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>

"scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-j> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>

"scroll up hover doc
nnoremap <silent> <C-k> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

"show signature help
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>

"rename
nnoremap <silent>gr <cmd>lua require('lspsaga.rename').rename()<CR>

"preview
nnoremap <silent> gD <cmd>lua require'lspsaga.provider'.preview_definition()<CR>

"show diagnostics
nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>

" jump diagnostic
nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
