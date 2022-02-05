command! -nargs=0 BaseLSInstall lua require("lsp.base-install-ls").auto_install_lsp()
command! -nargs=0 Format lua vim.lsp.buf.formatting()
command! -nargs=0 NewScratchBelow call MyFunctions#NewScratchBelow()
