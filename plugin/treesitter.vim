if has("nvim-0.5")
	lua require'nvim-treesitter.configs'.setup { ensure_installed = "maintained", highlight = { enable = true }}
endif
