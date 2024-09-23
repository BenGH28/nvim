vim.api.nvim_create_user_command("TrimSpace", [[:%s/\s\+$//ge]], { nargs = 0 })
