-- =============================================================
-- non-leader mappings
-- =============================================================

-- alias the long function
local setmap = vim.api.nvim_set_keymap

local noremap = {noremap = true}
local silence = {noremap = true, silent = true}

setmap("i", "jk", "<ESC>", noremap)
setmap("i", "kj", "<ESC>", noremap)

setmap("n", "Y", "y$", noremap)
setmap("n", "0", "0^", noremap)

-- windows
setmap("n", "<C-h>", ":wincmd h<CR>", silence)
setmap("n", "<C-j>", ":wincmd j<CR>", silence)
setmap("n", "<C-k>", ":wincmd k<CR>", silence)
setmap("n", "<C-l>", ":wincmd l<CR>", silence)

--Ctrl-Backspace will delete the word behind the cursor in --INSERT--
setmap("i", "<C-h>", "<C-O>b<C-O>dw", noremap)
