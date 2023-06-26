return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
      {
        "neovim/nvim-lspconfig",
        config = function()
          require "core.ide.lsp"
        end,
      },
      -- snippet fill
      { "rafamadriz/friendly-snippets" },

      -- pictograms for the lsp
      { "onsails/lspkind-nvim" },

      -- lsp front end that looks nice
      { "tami5/lspsaga.nvim" },

      -- add in some nice formatting and linting stuff
      { "jose-elias-alvarez/null-ls.nvim" },

      -- rust ide stuff
      { "simrat39/rust-tools.nvim" },

      -- diagnostics
      { "folke/trouble.nvim" },

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

    event = "InsertEnter",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"]( -1)
      end, { expr = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require "core.ide.autopairs"
    end,
  },

  -- Session persistence
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function()
      require("persistence").setup()
    end,
  },
}
