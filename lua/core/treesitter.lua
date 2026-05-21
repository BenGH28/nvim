-- keymaps
vim.keymap.set("n", "<leader>a", function()
  require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
end)
vim.keymap.set("n", "<leader>A", function()
  require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
end)

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
