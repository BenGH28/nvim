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
    build = ":Neorg sync-parsers",
    dependencies = "nvim-lua/plenary.nvim",
    opts = require "core.norg"
  },

  { "fladson/vim-kitty", ft = "kitty" },
}
