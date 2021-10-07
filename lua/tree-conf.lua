vim.g.nvim_tree_ignore = {".git", "node_modules", ".cache", ".undo"} -- empty by default
vim.g.nvim_tree_follow = 1 -- 0 by default, this option allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open
vim.g.nvim_tree_hide_dotfiles = 0 -- 0 by default, this option hides files and folders starting with a dot `.`
vim.g.nvim_tree_git_hl = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
vim.g.nvim_tree_show_icons = {git = 1, folders = 1, files = 1, folder_arrows = 1}

vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "★"
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = ""
  }
}

require "nvim-tree".setup {
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = true,
  ignore_ft_on_setup = {"startify"},
  update_to_buf_dir = {
    enable = true,
    auto_open = true
  },
  auto_close = true,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = false,
  lsp_diagnostics = false,
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {}
  },
  system_open = {
    cmd = nil,
    args = {}
  },
  view = {
    width = 30,
    height = 30,
    side = "left",
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}

local setmap = vim.api.nvim_set_keymap
local opt = {noremap = true}

setmap("n", "<C-n>", ":NvimTreeToggle<CR>", opt)
