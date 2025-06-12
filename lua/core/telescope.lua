local actions = require "telescope.actions"

local theme = "ivy"
require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    },
  },
  pickers = {
    -- TODO: find a better way to set the default theme
    live_grep = {
      theme = theme
    },
    find_files = {
      theme = theme,
      hidden = false,
    },
    buffers = { theme = theme },
    help_tags = {
      theme = theme
    },
    oldfiles = {
      theme = theme
    },
    git_files = {
      theme = theme
    }
  },

  defaults = {
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--color=auto",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    path_display = {
      "absolute",
    },
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    winblend = 0,
    border = true,
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  },
}

require("telescope").load_extension "file_browser"
require("telescope").load_extension("ui-select")
