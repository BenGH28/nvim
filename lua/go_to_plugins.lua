M = {}

function M.configs(opts)
  local defaults = {
    direction = "bottom" -- "left", "right", "top", "bottom", "tab", "full"
  }
  -- override defaults with user opts
  opts = vim.tbl_deep_extend("force", defaults, opts)
  local explore = {
    left = "Lexplore",
    right = "Lexplore!",
    bottom = "Hexplore",
    top = "Hexplore!",
    tabbed = "Texplore",
    full = "Explore",
  }
  local configs = vim.fn.stdpath "config"
  vim.cmd(explore[opts.direction] .. " " .. configs)
end

return M
