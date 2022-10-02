local spec = {
  {
    "BenGH28/neo-runner.nvim",
    cmd = "NeoRunner",
    run = ":UpdateRemotePlugins",
  },

  { 'rcarriga/nvim-notify',
    config = function()
      require('notify').setup {
        background_color = "#282c34",
        fps = 30,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "✎",
          WARN = ""
        },
        level = 2,
        minimum_width = 50,
        render = "simple",
        stages = "static",
        timeout = 5000,
        top_down = true
      }
      vim.notify = require("notify")
    end
  },

  { "lambdalisue/suda.vim" },

  { "moll/vim-bbye" },

  {
    "phaazon/hop.nvim",
    event = "BufEnter",
    keys = { "gl", "gp" },
    config = function()
      require("hop").setup { keys = "etovxqpdygfblzhckisuran", term_seq_bias = 1.5 }
    end,
  },
  {
    "nvim-lua/telescope.nvim",
    requires = { "nvim-telescope/telescope-file-browser.nvim" },
    event = "UIEnter",
    -- disable = true,
    config = function()
      require "core.tools.telescope-conf"
    end,
  },

  -- tpope
  { "tpope/vim-commentary" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },

  { "unblevable/quick-scope",
    setup = function()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
      vim.g.qs_max_chars = 150
      vim.cmd [[highlight QuickScopePrimary guifg='#61afe0' gui=underline ctermfg=155 cterm=underline]]
      vim.cmd [[highlight QuickScopeSecondary guifg='#98d379' gui=underline ctermfg=81 cterm=underline]]
    end
  },
}

return spec
