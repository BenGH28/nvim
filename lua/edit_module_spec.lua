local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

M = {}

local split_str = function(input, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(input, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

local open_spec_file = function(path)
	vim.api.nvim_command("e " .. path .. "/spec.lua")
end

local dirs_only = function(mods)
	local dirs = {}
	for _, path in pairs(mods) do
		-- find any lua files
		local result = string.find(path, "lua$")
		if result == nil then
			table.insert(dirs, path)
		end
	end
	return dirs
end

M.edit = function(opts)
	opts = opts or {}

	local core = vim.fn.stdpath "config" .. "/lua/core"
	local all_mods = vim.fn.globpath(core, "*")
	local mods = split_str(all_mods, "\n")

	pickers.new(opts, {
		prompt_title = "edit module spec",
		finder = finders.new_table {
			results = dirs_only(mods),
			-- entry_maker = function(entry)
			-- 	return {
			-- 		value = entry,
			-- 		display = entry[1],
			-- 		ordinal = entry[1],
			-- 	}
			-- end,
		},
		sorter = conf.generic_sorter(opts),

		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				-- print(vim.inspect(selection))
				open_spec_file(selection[1])
			end)
			return true
		end,
	}):find()
end

return M
