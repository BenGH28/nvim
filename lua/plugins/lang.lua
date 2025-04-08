return {
  {
    "tmux-plugins/vim-tmux",
    ft = "tmux"
  },
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
    'MeanderingProgrammer/render-markdown.nvim',
    ft = "markdown",
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("render-markdown").setup({})
    end
  },

  { "fladson/vim-kitty",                    ft = "kitty" },
}
