return {
  { "folke/which-key.nvim" },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("ibl").setup {
        exclude = {
          buftypes = { "terminal", "help", "startify", "nofile", "NvimTree" },
          filetypes = { "help", "packer", "startify", "NvimTree", "alpha", "norg" },
        },
      }
    end,
  },

  -- todo comments that stand out
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "BufRead",
    config = function()
      require "core.ui.todo-comments"
    end,
  },

  -- really fast startify alternative
  {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require "core.ui.startify"
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    lazy = false,
    config = function()
      require("colorizer").setup()
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require "core.ui.lualine"
    end,
  },

  {
    "JoosepAlviste/palenightfall.nvim",
    lazy = false
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require "core.ui.gruv"
    end
  },
  { "catppuccin/nvim",             lazy = false, },
  { "dracula/vim",                 lazy = false, },
  { "shaunsingh/nord.nvim",        lazy = false, },
  { "folke/tokyonight.nvim",       lazy = false, },
  { "marko-cerovac/material.nvim", lazy = false, },
  { "Shatur/neovim-ayu",           lazy = false, },
  { "olimorris/onedarkpro.nvim",   lazy = false, },
}
