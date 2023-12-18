return {

  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    config = function()
      require("gitsigns").setup {}
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
  },

  {
    "APZelos/blamer.nvim",
    cond = vim.loop.os_uname().sysname == "Linux",
    config = function()
      require("blamer").setup()
    end,

    event = "BufEnter",
    commit = "afd2fde1989b84f4a69639f25d8f4f60519b5cc7",
    init = function()
      vim.g.blamer_enabled = true
    end,
  },
}
