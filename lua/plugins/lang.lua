return {

  { "tmux-plugins/vim-tmux" },

  {
    "xuhdev/vim-latex-live-preview",
    ft = "tex",
    init = function()
      --run this before we load
      vim.g["livepreview_previewer"] = "okular"
    end,
  },

  { "davidgranstrom/nvim-markdown-preview", ft = "markdown" },

  {
    "nvim-neorg/neorg",
    ft = "norg",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require "core.lang.norg-conf"
    end,
  },

  { "fladson/vim-kitty" },
}
