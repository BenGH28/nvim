require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained",
	ignore_install = { "latex" },
	sync_install = false,
	highlight = { enable = true },
})
