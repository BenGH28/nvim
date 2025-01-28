local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

local languages = {
  "bash",
  "c",
  "cpp",
  "css",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "html",
  "javascript",
  "lua",
  "markdown",
  "nu",
  "python",
  "rust",
  "sql",
  "toml",
  "tsx",
  "typescript",
  "yaml",
}

local opts = {
  ensure_installed = languages,
  sync_install = false,
  indent = { enable = true },
  highlight = { enable = true },
  -- plugin modules
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
  -- just the stuff in the DOCS for now
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["aa"] = "@assignment.outer",
        ["ia"] = "@assignment.inner",
      },
    },
  },
}

require("nvim-treesitter.configs").setup(opts)

-- a command to help fix this issue: https://github.com/nvim-treesitter/nvim-treesitter/issues/3092
-- clear a language parser and its associated queries
vim.api.nvim_create_user_command("TSRefreshLang", function(args)
  local lang = args.args
  local libs = vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", true)
  local queries = vim.api.nvim_get_runtime_file("queries/" .. lang .. ".scm", true)

  for _, lib in ipairs(libs) do
    local cmd = "rm -f " .. lib
    -- ignore files in /usr/share/nvim/parser
    if vim.fn.fnamemodify(lib, ":h") ~= "/usr/share/nvim/parser" then
      os.execute(cmd)
    end
  end
  for _, query in ipairs(queries) do
    local cmd = "rm -f " .. query
    os.execute(cmd)
  end

  vim.cmd("TSInstall! " .. lang)
end, { force = true, nargs = 1, complete = "custom,nvim_treesitter#installable_parsers" })
