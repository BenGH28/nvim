local go_err = function()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local lines = {
    "if err != nil {",
    "\t",
    "}",
  }
  vim.api.nvim_buf_set_lines(0, row, row + 2, false, lines)
  vim.cmd(":normal va{=")
  vim.api.nvim_win_set_cursor(0, { row + 2, 1 })
end
vim.api.nvim_create_user_command("GoErr", go_err, {})

vim.keymap.set("n", "<leader>lg", go_err)
