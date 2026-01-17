local setmap = vim.keymap.set

-- move you selections in visual mode
setmap("v", "J", ":m '>+1<CR>gv=gv")
setmap("v", "K", ":m '<-2<CR>gv=gv")

local noremap = { noremap = true }
local silence = { noremap = true, silent = true }

setmap("i", "jk", "<ESC>", noremap)
setmap("i", "kj", "<ESC>", noremap)

--Ctrl-Backspace will delete the word behind the cursor in INSERT mode
setmap("i", "<C-h>", "<C-w>", noremap)

-- I really want this to work too but alas no dice
-- setmap("c", "<C-BS>", "<C-w>", noremap)


setmap("n", "Y", "y$", noremap)
setmap("n", "0", "0^", noremap)

-- windows
setmap("n", "<C-h>", ":wincmd h<CR>", silence)
setmap("n", "<C-j>", ":wincmd j<CR>", silence)
setmap("n", "<C-k>", ":wincmd k<CR>", silence)
setmap("n", "<C-l>", ":wincmd l<CR>", silence)
setmap("n", "n", "nzz", silence)
setmap("n", "N", "Nzz", silence)

setmap("n", "K", function()
  vim.lsp.buf.hover({ border = 'rounded' })
end, silence)

--terminal escape
--need to escape \ in the lua api
setmap("t", "<Esc><Esc>", "<C-\\><C-n>", noremap)

-- }}} regular
