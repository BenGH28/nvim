vim.bo.tabstop = 4
vim.bo.shiftwidth = 4

vim.keymap.set("n", "<leader>i", "A #type: ignore<esc>", { desc = "insert ignore statement", buffer = true })
