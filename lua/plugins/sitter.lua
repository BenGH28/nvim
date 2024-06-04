return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "p00f/nvim-ts-rainbow",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "nushell/tree-sitter-nu",
    },
    config = function()
      require "core.treesitter"
    end,
  },
}
