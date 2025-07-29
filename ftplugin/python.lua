vim.bo.tabstop = 4
vim.bo.shiftwidth = 4

vim.keymap.set("n", "<leader>pti", "A # type: ignore<esc>", { desc = "insert ignore statement", buffer = true })
vim.keymap.set("n", "<leader>ptt", "A # type: ", { desc = "insert open-ended type statement", buffer = true })
vim.keymap.set("n", "<leader>pn", "A # noqa: ", { desc = "insert noqa statement", buffer = true })
