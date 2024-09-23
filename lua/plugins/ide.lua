return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "core.ide.lsp"
    end,

    dependencies = {
      {
        "williamboman/mason.nvim",
        cmd = { "MasonUpdate", "Mason" }
      },

      {
        "williamboman/mason-lspconfig.nvim",
      },

      -- snippet fill
      { "rafamadriz/friendly-snippets", enabled = false },

      -- pictograms for the lsp
      {
        "onsails/lspkind-nvim",
        config = function()
          require("lspkind").init()
        end,
      },
      {
        "TheLeoP/powershell.nvim",
        ---@type powershell.user_config
        opts = {
          bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
          shell = "powershell.exe",
        }
      },

      -- lsp front end that looks nice
      { "nvimdev/lspsaga.nvim" },

      -- rust ide stuff
      { "simrat39/rust-tools.nvim" },

      -- diagnostics
      {
        "folke/trouble.nvim",
        opts = {}
      },

      -- neovim help
      { "folke/neodev.nvim" },

      -- get some snippet support
      {
        "hrsh7th/vim-vsnip",
        setup = function()
          vim.g.vsnip_snippet_dir = vim.fn.stdpath "config" .. "/vsnip"
        end,
      },
      {
        "mfussenegger/nvim-dap",
      },
    },
  },

  {
    "vim-scripts/DoxygenToolkit.vim",
    ft = { "cpp", "c", "javascript" },
    config = function()
      require "core.ide.doxygen"
    end,
  },

  {
    "Exafunction/codeium.vim",
    cmd = "Codeium",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })
    end,
  },

  -- Session persistence
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {},
  },
}
