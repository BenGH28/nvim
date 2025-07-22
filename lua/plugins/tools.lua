return {
  {
    "m4xshen/hardtime.nvim",
    cmd = "Hardtime",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {}
  },
  {
    "BenGH28/koin.nvim",
    cmd = { "Koin", "KoinLast", "KoinClear" },
    config = function()
      require "koin".setup()
    end,
    keys = {
      {
        "<leader>gl",
        "<cmd>Koin lazygit<cr>",
        desc = "lazygit"
      }
    }

  },
  {
    "LunarVim/bigfile.nvim",
    event = "VeryLazy",
    opts = {},
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
      require("mini.jump2d").setup()
    end,
    keys = {
      { "<leader>mj", "<cmd>lua MiniJump2d.start()<enter>", desc = "mini jump2d" }
    }
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
      { "nvim-telescope/telescope-ui-select.nvim" },

    },
  },

  -- tpope
  { "tpope/vim-commentary", event = "BufEnter" },
  { "tpope/vim-surround",   event = "BufEnter" },
  { "tpope/vim-repeat",     event = "BufEnter" },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { 'sql', 'mysql', 'plsql' },
        callback = function()
          require('cmp').setup.buffer({ sources = { { name = 'vim-dadbod-completion' } } })
        end
      })
    end
  },

  {
    "unblevable/quick-scope",
    event = "VeryLazy",
    init = function()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
      vim.g.qs_max_chars = 150
    end,
    config = function()
      -- need to have this after the plugin loads and not before
      vim.api.nvim_set_hl(0, "QuickScopePrimary", { underline = true, fg = "#61afe0" })
      vim.api.nvim_set_hl(0, "QuickScopeSecondary", { underline = true, fg = "#98d379" })
    end,
  },

  {
    'smoka7/hop.nvim',
    version = "*",
    opts = {},
    event = "BufEnter",
  },
}
