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

function M.edit_telescope(opts)
  opts = opts or {}

  local plugins = vim.fn.stdpath "config" .. "/lua/plugins"
  local all_mods = vim.fn.globpath(plugins, "*")
  local mods = split_str(all_mods, "\n")

  pickers
      .new(opts, {
        prompt_title = "edit module spec",
        finder = finders.new_table {
          results = mods,
          -- entry_maker = function(entry)
          -- 	return {
          -- 		value = entry,
          -- 		display = entry[1],
          -- 		ordinal = entry[1],
          -- 	}
          -- end,
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            -- print(vim.inspect(selection))
            open_spec_file(selection[1])
          end)
          return true
        end,
      })
      :find()
end

function M:edit()
  self.edit_telescope(require("telescope.themes").get_dropdown())
end

return M
