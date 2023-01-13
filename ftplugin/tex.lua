vim.cmd [[let maplocalleader = ',']]
vim.keymap.set("n", "<LocalLeader>p", ":LLPStartPreview<cr>")
vim.keymap.set("n", "<LocalLeader>c", "!pdflatex %<cr>")
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_us", "en_ca" }
