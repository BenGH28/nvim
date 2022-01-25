vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.commentstring = "// %s"

-- local dap_install = require("dap-install")
-- dap_install.config("ccppr_vsc", {})

-- local dap = require("dap")
-- dap.adapters.lldb = {
--   type = "executable",
--   command = "/usr/bin/lldb-vscode", -- adjust as needed
--   name = "lldb"
-- }

-- dap.configurations.cpp = {
--   {
--     name = "Launch file",
--     type = "cppdbg",
--     request = "launch",
--     program = function()
--       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--     end,
--     cwd = "${workspaceFolder}",
--     stopOnEntry = true
--   },
--   {
--     name = "Attach to gdbserver :1234",
--     type = "cppdbg",
--     request = "launch",
--     MIMode = "gdb",
--     miDebuggerServerAddress = "localhost:1234",
--     miDebuggerPath = "/usr/bin/gdb",
--     cwd = "${workspaceFolder}",
--     program = function()
--       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--     end
--   }
-- }
