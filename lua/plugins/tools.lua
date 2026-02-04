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
      require("notify").setup({
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
        merge_duplicates = true,
      })
      vim.notify = require "notify"
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.trailspace").setup()
      require("mini.splitjoin").setup()
      require("mini.bufremove").setup()
      require("mini.jump2d").setup({ mappings = { start_jumping = "<leader>mj" } })
    end,
  },

  { "lambdalisue/suda.vim",                 cmd = { "SudaRead", "SudaWrite" } },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "nvim-mini/mini.icons" },
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostic disable: missing-fields
    opts = {}
    ---@diagnostic enable: missing-fields
  },


  {
    "nvim-telescope/telescope-file-browser.nvim",

    config = function()
      require("telescope").load_extension "file_browser"
    end,

  },
  { "nvim-telescope/telescope-symbols.nvim" },
  {
    "nvim-telescope/telescope-ui-select.nvim",

    config = function()
      require("telescope").load_extension "frecency"
      require("telescope").load_extension "file_browser"
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    -- install the latest stable version
    version = "*",
    config = function()
      require("telescope").load_extension "frecency"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require "core.telescope"
    end,
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
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      { "<leader>a",  nil,                              desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
    opts = {
      -- Server Configuration
      port_range = { min = 10000, max = 65535 },
      auto_start = true,
      log_level = "info",                                         -- "trace", "debug", "info", "warn", "error"
      terminal_cmd = "C:\\Users\\bhunt\\.local\\bin\\claude.exe", -- Custom terminal command (default: "claude")
      -- For local installations: "~/.claude/local/claude"
      -- For native binary: use output from 'which claude'

      -- Send/Focus Behavior
      -- When true, successful sends will focus the Claude terminal if already connected
      focus_after_send = false,

      -- Selection Tracking
      track_selection = true,
      visual_demotion_delay_ms = 50,

      -- Terminal Configuration
      terminal = {
        split_side = "right", -- "left" or "right"
        split_width_percentage = 0.30,
        provider = "auto",    -- "auto", "snacks", "native", "external", "none", or custom provider table
        auto_close = true,
        snacks_win_opts = {}, -- Opts to pass to `Snacks.terminal.open()` - see Floating Window section below

        -- Provider-specific options
        provider_opts = {
          -- Command for external terminal provider. Can be:
          -- 1. String with %s placeholder: "alacritty -e %s" (backward compatible)
          -- 2. String with two %s placeholders: "alacritty --working-directory %s -e %s" (cwd, command)
          -- 3. Function returning command: function(cmd, env) return "alacritty -e " .. cmd end
          external_terminal_cmd = nil,
        },
      },
      config = true,

      -- Diff Integration
      diff_opts = {
        auto_close_on_accept = true,
        vertical_split = true,
        open_in_current_tab = true,
        keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
      },
    },
  }
}
