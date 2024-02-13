return {


  {
    "LunarVim/bigfile.nvim",
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      require("notify").setup {
        background_color = "#282c34",
        fps = 30,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "✎",
          WARN = "",
        },
        level = 2,
        minimum_width = 50,
        render = "simple",
        stages = "static",
        timeout = 5000,
        top_down = true,
      }
      vim.notify = require "notify"
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.trailspace").setup()
      require("mini.splitjoin").setup()
    end,
  },

  { "lambdalisue/suda.vim", cmd = { "SudaRead", "SudaWrite" } },
  { "moll/vim-bbye",        cmd = "Bdelete" },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require "core.telescope"
    end,
    dependencies = {
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "nvim-telescope/telescope-symbols.nvim" },
      {
        "ahmedkhalf/project.nvim",
        config = function()
          require "core.project"
        end,
      },
    },
  },

  -- tpope
  { "tpope/vim-commentary", event = "BufEnter" },
  { "tpope/vim-surround",   event = "BufEnter" },
  { "tpope/vim-repeat",     event = "BufEnter" },

  {
    "unblevable/quick-scope",
    event = "VeryLazy",
    init = function()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
      vim.g.qs_max_chars = 150
    end,
    config = function()
      -- need to have this after the plugin loads and not before which now I think of it should be obvious
      vim.api.nvim_set_hl(0, "QuickScopePrimary", { underline = true, fg = "#61afe0" })
      vim.api.nvim_set_hl(0, "QuickScopeSecondary", { underline = true, fg = "#98d379" })
    end,
  },

  {
    "ggandor/leap.nvim",
    enabled = false,
    config = function()
      require("leap").add_default_mappings()
    end,

  }
}
