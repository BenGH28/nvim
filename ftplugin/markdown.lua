local glow = function()
  local filename = vim.api.nvim_buf_get_name(0)
  local koin = require "koin"
  local cmd = "glow -p " .. filename
  koin.show(cmd)
end

vim.keymap.set("n", "<leader>fm", glow, { desc = "render markdown with glow" })

vim.api.nvim_buf_create_user_command(0, "Glow", glow, {})
