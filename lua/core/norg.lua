return {
  load = {
    ["core.defaults"] = {},
    ["core.export"] = {},
    ["core.export.markdown"] = {},
    ["core.completion"] = { config = { engine = "nvim-cmp" } },
    ["core.concealer"] = {},
    ["core.keybinds"] = {
      config = {
        hook = function(keybinds)
          keybinds.remap(
            "norg",
            "n",
            "<leader>ngd",
            "<cmd>Neorg keybind norg core.norg.qol.todo_items.todo.task_done<cr>"
          )
          keybinds.remap(
            "norg",
            "n",
            "<leader>ngu",
            "<cmd>Neorg keybind norg core.norg.qol.todo_items.todo.task_undone<cr>"
          )
          keybinds.remap(
            "norg",
            "n",
            "<leader>ngp",
            "<cmd>Neorg keybind norg core.norg.qol.todo_items.todo.task_pending<cr>"
          )
          keybinds.remap(
            "norg",
            "n",
            "<leader>ngh",
            "<cmd>Neorg keybind norg core.norg.qol.todo_items.todo.task_on_hold<cr>"
          )
          keybinds.remap(
            "norg",
            "n",
            "<leader>ngc",
            "<cmd>Neorg keybind norg core.norg.qol.todo_items.todo.task_cancelled<cr>"
          )
          keybinds.remap(
            "norg",
            "n",
            "<leader>ngr",
            "<cmd>Neorg keybind norg core.norg.qol.todo_items.todo.task_recurring<cr>"
          )
          keybinds.remap(
            "norg",
            "n",
            "<leader>ngi",
            "<cmd>Neorg keybind norg core.norg.qol.todo_items.todo.task_important<cr>"
          )
          keybinds.remap(
            "norg",
            "n",
            "<leader>ngC",
            "<cmd>Neorg keybind norg core.norg.qol.todo_items.todo.task_cycle<cr>"
          )
        end,
      },
    },
  },
}
