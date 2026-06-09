local M = {}

M._root = nil
M._active = nil
M._exclude = {}
M._ignore_hidden = true

function M.setup(opts)
  M._root = opts and opts.root or M._root
  if opts and opts.exclude then
    M._exclude = {}
    for _, v in ipairs(opts.exclude) do
      M._exclude[v] = true
    end
  end
  if opts and opts.ignore_hidden ~= nil then
    M._ignore_hidden = opts.ignore_hidden
  end
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

local function scan_subdirs(path)
  local dirs = {}
  local handle = vim.loop.fs_scandir(path)
  if handle then
    while true do
      local name, type = vim.loop.fs_scandir_next(handle)
      if not name then break end
      if type == "directory" and not M._exclude[name]
          and (not M._ignore_hidden or string.sub(name, 1, 1) ~= ".") then
        table.insert(dirs, name)
      end
    end
  end
  table.sort(dirs)
  return dirs
end

local function pick(subpath)
  local abs_path = subpath == "" and M._root or (M._root .. "\\" .. subpath)
  local subdirs = scan_subdirs(abs_path)

  local entries = {}
  if subpath == "" then
    table.insert(entries, { label = "[all projects]", action = "clear" })
  else
    table.insert(entries, { label = "[select: " .. subpath .. "]", action = "select", value = subpath })
  end
  for _, name in ipairs(subdirs) do
    local rel = subpath == "" and name or (subpath .. "\\" .. name)
    table.insert(entries, { label = name, action = "drill", value = rel })
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local themes = require("telescope.themes")

  local title = subpath == "" and "Select Project" or ("Project: " .. subpath)

  pickers.new(themes.get_ivy({}), {
    prompt_title = title,
    finder = finders.new_table({
      results = entries,
      entry_maker = function(e)
        return { value = e, display = e.label, ordinal = e.label }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if not selection then return end
        local e = selection.value
        if e.action == "clear" then
          M.clear()
        elseif e.action == "select" then
          M._active = e.value
          vim.notify("[monorepo] project: " .. e.value, vim.log.levels.INFO)
        elseif e.action == "drill" then
          vim.schedule(function() pick(e.value) end)
        end
      end)
      return true
    end,
  }):find()
end

function M.select_project()
  if not M._root then
    vim.notify("[monorepo] no root configured", vim.log.levels.WARN)
    return
  end
  pick("")
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
