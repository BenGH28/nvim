return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        opts = {}
      },
      {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
          require('rainbow-delimiters.setup').setup {}
        end
      },
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "nushell/tree-sitter-nu",
    },
    config = function()
      require "core.treesitter"
    end,
  },
}
