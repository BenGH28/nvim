local M = {}

M._root = nil
M._active = nil

function M.setup(opts)
  M._root = opts and opts.root or M._root
end

function M.get_cwd()
  if M._active then
    return M._root .. "\\" .. M._active
  end
  return M._root
end

function M.clear()
  M._active = nil
  vim.notify("[monorepo] scope cleared", vim.log.levels.INFO)
end

function M.select_project()
  if not M._root then
    vim.notify("[monorepo] no root configured", vim.log.levels.WARN)
    return
  end

  local entries = { "[all projects]" }
  local handle = vim.loop.fs_scandir(M._root)
  if handle then
    while true do
      local name, type = vim.loop.fs_scandir_next(handle)
      if not name then break end
      if type == "directory" then
        table.insert(entries, name)
      end
    end
  end
  table.sort(entries, function(a, b)
    if a == "[all projects]" then return true end
    if b == "[all projects]" then return false end
    return a < b
  end)

  local telescope = require("telescope")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local themes = require("telescope.themes")

  pickers.new(themes.get_ivy({}), {
    prompt_title = "Select Project",
    finder = finders.new_table({ results = entries }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if not selection then return end
        local val = selection[1]
        if val == "[all projects]" then
          M.clear()
        else
          M._active = val
          vim.notify("[monorepo] project: " .. val, vim.log.levels.INFO)
        end
      end)
      return true
    end,
  }):find()
end

function M.find_files()
  require("telescope.builtin").find_files({
    cwd = M.get_cwd(),
    prompt_title = "Files [" .. (M._active or "all") .. "]",
  })
end

function M.live_grep()
  require("telescope.builtin").live_grep({
    cwd = M.get_cwd(),
    prompt_title = "Grep [" .. (M._active or "all") .. "]",
  })
end

return M
