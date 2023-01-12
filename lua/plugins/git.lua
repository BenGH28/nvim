return {

  { "lewis6991/gitsigns.nvim", event = "BufEnter" },

  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    -- disable = true
  },

  {
    "APZelos/blamer.nvim",
    event = "BufEnter",
    init = function()
      vim.g.blamer_enabled = 1
    end,
  },
}
