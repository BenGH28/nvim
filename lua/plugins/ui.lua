return {
  { "folke/which-key.nvim" },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("indent_blankline").setup {
        buftype_exclude = { "terminal", "help", "startify", "nofile", "NvimTree" },
        filetype_exclude = { "help", "packer", "startify", "NvimTree", "alpha", "norg" },
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
    "akinsho/nvim-bufferline.lua",
    event = "VeryLazy",
    version = "v2.*",
    config = function()
      require "core.ui.bufferline"
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
    cmd = "NvimTreeToggle",
    config = function()
      require "core.ui.tree"
    end,
  },

  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "smiteshp/nvim-navic",
    },
    config = function()
      require "core.ui.barbecue"
    end,
  },
  -- colorscheme
  { "Domeee/mosel.nvim", lazy = false },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require "core.ui.onedark"
    end,
  },
}
