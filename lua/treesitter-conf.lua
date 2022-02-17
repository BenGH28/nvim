local opts = {
	ensure_installed = "maintained",
	ignore_install = { "latex" },
	sync_install = false,
	highlight = { enable = true },
	autotag = { enable = true },
}

require("nvim-treesitter.configs").setup(opts)
