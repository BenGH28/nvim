local M = {}

M._root = nil
M._active = nil
M._exclude = {}
M._ignore_hidden = true
M._file_exclude = {}

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
  if opts and opts.file_exclude then
    M._file_exclude = opts.file_exclude
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

local function scan_all(base, rel, results)
  local abs = rel == "" and base or (base .. "\\" .. rel)
  local handle = vim.loop.fs_scandir(abs)
  if not handle then return end
  local children = {}
  while true do
    local name, type = vim.loop.fs_scandir_next(handle)
    if not name then break end
    if type == "directory" and not M._exclude[name]
        and (not M._ignore_hidden or string.sub(name, 1, 1) ~= ".") then
      table.insert(children, name)
    end
  end
  table.sort(children)
  for _, name in ipairs(children) do
    local child_rel = rel == "" and name or (rel .. "\\" .. name)
    table.insert(results, child_rel)
    scan_all(base, child_rel, results)
  end
end

local function pick()
  local all = {}
  scan_all(M._root, "", all)

  -- sort by parent dir, then by name within that parent
  table.sort(all, function(a, b)
    local pa = a:match("^(.+)\\[^\\]+$") or ""
    local pb = b:match("^(.+)\\[^\\]+$") or ""
    if pa ~= pb then return pa < pb end
    return a < b
  end)

  local entries = { { label = "[all projects]", value = nil } }
  for _, rel in ipairs(all) do
    table.insert(entries, { label = rel, value = rel })
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local themes = require("telescope.themes")

  pickers.new(themes.get_ivy({}), {
    prompt_title = "Select Project",
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
        if e.value == nil then
          M.clear()
        else
          M._active = e.value
          vim.notify("[monorepo] project: " .. e.value, vim.log.levels.INFO)
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
  pick()
end

local function file_exclude_args()
  local args = {}
  for _, pattern in ipairs(M._file_exclude) do
    table.insert(args, "--glob")
    table.insert(args, "!" .. pattern)
  end
  return args
end

function M.find_files()
  local extra = file_exclude_args()
  local cmd = { "rg", "--files", "--color", "never" }
  vim.list_extend(cmd, extra)
  require("telescope.builtin").find_files({
    cwd = M.get_cwd(),
    prompt_title = "Files [" .. (M._active or "all") .. "]",
    find_command = #extra > 0 and cmd or nil,
  })
end

function M.live_grep()
  local extra = file_exclude_args()
  require("telescope.builtin").live_grep({
    cwd = M.get_cwd(),
    prompt_title = "Grep [" .. (M._active or "all") .. "]",
    additional_args = #extra > 0 and extra or nil,
  })
end

return M
