vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.api.nvim_buf_create_user_command(0, 'BashRun', function()
    vim.cmd('!bash %')
end, {})
