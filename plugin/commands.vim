command! -nargs=0 Format lua vim.lsp.buf.format({async = true})
command! -nargs=0 NewScratchBelow call MyFunctions#NewScratchBelow()
