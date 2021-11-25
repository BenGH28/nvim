vim.opt.commentstring = "// %s"
vim.bo.autoindent = true
vim.bo.smartindent = false
vim.wo.foldmethod = "syntax"
vim.g.verilog_syntax_fold_lst = "all"
vim.cmd [[setlocal makeprg=iverilog]]
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
