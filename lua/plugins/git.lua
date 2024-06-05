return {
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "lewis6991/gitsigns.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup {
        current_line_blame = true,
      }
    end,
  },
}
