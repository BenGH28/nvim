return {
  "tmux-plugins/vim-tmux",
  {
    "xuhdev/vim-latex-live-preview",
    ft = "tex",
    init = function()
      --run this before we load
      vim.g["livepreview_previewer"] = "okular"
    end,
  },

  { "davidgranstrom/nvim-markdown-preview", ft = "markdown" },

  { "fladson/vim-kitty",                    ft = "kitty" },
}
