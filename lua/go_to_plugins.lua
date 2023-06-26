local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

M = {}

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
  vim.api.nvim_command("e " .. path)
end

function M.edit_telescope(opts, file_paths, prompt_title)
  opts = opts or {}

  local all_mods = vim.fn.globpath(file_paths, "**/*.lua")
  local mods = split_str(all_mods, "\n")

  pickers
      .new(opts, {
        prompt_title = prompt_title,
        finder = finders.new_table {
          results = mods,
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            open_spec_file(selection[1])
          end)
          return true
        end,
      })
      :find()
end

function M:plugins()
  local plugins = vim.fn.stdpath "config" .. "/lua/plugins"
  self.edit_telescope(require("telescope.themes").get_dropdown(), plugins, "edit module spec")
end

function M:configs()
  local configs = vim.fn.stdpath "config" .. "/lua/core/"
  self.edit_telescope(require("telescope.themes").get_dropdown(), configs, "edit config")
end

return M
