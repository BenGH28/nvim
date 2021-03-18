vim.api.nvim_exec([[
nnoremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>
nnoremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>
nnoremap * *<Cmd>lua require('hlslens').start()<CR>
nnoremap # #<Cmd>lua require('hlslens').start()<CR>
nnoremap g* g*<Cmd>lua require('hlslens').start()<CR>
nnoremap g# g#<Cmd>lua require('hlslens').start()<CR>

" use : instead of <Cmd>
nnoremap <silent> <leader>l :nohlsearch<CR>
]], false)

