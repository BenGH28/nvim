require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.norg.completion"] = { config = {
			engine = "nvim-cmp",
		} },
		["core.norg.concealer"] = {},
		["core.keybinds"] = {
			config = {
				hook = function(keybinds)
					keybinds.remap_event("norg", "n", "<leader>nd", "core.norg.qol.todo_items.todo.task_done")
					keybinds.remap_event("norg", "n", "<leader>nu", "core.norg.qol.todo_items.todo.task_undone")
					keybinds.remap_event("norg", "n", "<leader>np", "core.norg.qol.todo_items.todo.task_pending")
					keybinds.remap_event("norg", "n", "<leader>nh", "core.norg.qol.todo_items.todo.task_on_hold")
					keybinds.remap_event("norg", "n", "<leader>nc", "core.norg.qol.todo_items.todo.task_cancelled")
					keybinds.remap_event("norg", "n", "<leader>nr", "core.norg.qol.todo_items.todo.task_recurring")
					keybinds.remap_event("norg", "n", "<leader>ni", "core.norg.qol.todo_items.todo.task_important")
					keybinds.remap_event("norg", "n", "<leader>nC", "core.norg.qol.todo_items.todo.task_cycle")
				end,
			},
		},
	},
})
