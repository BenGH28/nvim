-- a command to help fix this issue: https://github.com/nvim-treesitter/nvim-treesitter/issues/3092
-- clear a language parser and its associated queries
vim.api.nvim_create_user_command("TSPurgeAndRefreshLang", function(args)
  local lang = args.args
  local sofiles = vim.api.nvim_get_runtime_file("*/" .. lang .. ".so", true)
  local queries = vim.api.nvim_get_runtime_file("queries/" .. lang .. ".scm", true)
  for _, sofile in ipairs(sofiles) do
    os.execute("rm -f" .. sofile)
  end
  for _, query in ipairs(queries) do
    os.execute("rm -f" .. query)
  end
  vim.cmd("TSInstall! " .. lang)
end)
