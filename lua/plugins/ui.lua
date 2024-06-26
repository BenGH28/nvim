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
      require("alpha").setup(require("alpha.themes.startify").config)
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
    "cpea2506/one_monokai.nvim",
    lazy = true,
  },

  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000, -- Ensure it loads first
    config = function()
      require "core.ui.onedark"
    end,
  },
}
