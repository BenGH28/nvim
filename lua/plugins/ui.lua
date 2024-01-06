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
    event = "BufEnter",
    config = function()
      require("colorizer").setup()
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require "core.ui.lualine"
    end,
  },

  {
    "kyazdani42/nvim-tree.lua",
    enabled = false,
    cmd = "NvimTreeToggle",
    config = function()
      require "core.ui.tree"
    end,
  },

  {
    "cpea2506/one_monokai.nvim",
    lazy = false,
    config = function()
      require("one_monokai").setup({
        transparent = false,
        colors = {},
        italics = true,
      })
    end
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 3000,
  },
}
