local picker       = require "telescope.pickers"
local finders      = require "telescope.finders"
local themes       = require "telescope.themes"
local sorters      = require "telescope.sorters"
local actions      = require "telescope.actions"
local action_state = require "telescope.actions.state"
local previewers   = require "telescope.previewers"

M                  = {}

local function split_str(input, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(input, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local function open_spec_file(path)
  vim.cmd("e " .. path)
end

local function edit_telescope(theme, file_paths, prompt_title)
  theme = theme or {}

  local lua_files = vim.fn.globpath(file_paths, "**/*.lua")
  local mods = split_str(lua_files, "\n")

  local function on_select(prompt_bufnr, _)
    actions.select_default:replace(function()
      actions.close(prompt_bufnr)
      local selection = action_state.get_selected_entry()
      open_spec_file(selection[1])
    end)
    return true
  end

  local params = {
    prompt_title = prompt_title,
    finder = finders.new_table {
      results = mods,
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = on_select,
    previewer = previewers.cat.new {}
  }
  picker.new(theme, params):find()
end

function M.configs(opts)
  local defaults = {
    netrw = true,
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
  if opts.netrw == true then
    vim.cmd(explore[opts.direction] .. " " .. configs)
  else
    edit_telescope({}, configs, "edit config")
  end
end

return M
