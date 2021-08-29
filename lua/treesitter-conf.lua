require "nvim-treesitter.configs".setup {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "html",
    "json",
    "yaml",
    "lua",
    "python",
    "rust",
    "vim",
    "typescript",
    "toml"
  },
  highlight = {enable = true}
}
