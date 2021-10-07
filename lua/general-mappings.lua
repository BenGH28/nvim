-- =============================================================
--		Vim Mappings Only
-- =============================================================

-- alias the long function
local setmap = vim.api.nvim_set_keymap

local noremap = {noremap = true}
local silence = {noremap = true, silent = true}

setmap("i", "jk", "<ESC>", noremap)
setmap("i", "kj", "<ESC>", noremap)

setmap("n", "<Leader>ma", ":make<CR>", noremap)
setmap("n", "<Leader>mc", ":make clean<CR>", noremap)
setmap("n", "Y", "y$", noremap)
setmap("n", "0", "0^", noremap)

-- substitute word under cursor
setmap("n", "<Leader>swg", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], noremap)
setmap("n", "<Leader>swl", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], noremap)

setmap("n", "<Leader>bn", ":bNext<CR>", silence)
setmap("n", "<Leader>bp", ":bprevious<CR>", silence)

setmap("n", "<Leader>.", ":tabn<CR>", silence)
setmap("n", "<Leader>,", ":tabp<CR>", silence)

-- set background quickly if I'm not using alacritty
setmap("n", "<Leader>cl", ":set background=light<CR>", silence)
setmap("n", "<Leader>cd", ":set background=dark<CR>", silence)

-- alacritty themes
setmap("n", "<Leader>at", ":call MyFunctions#ToggleAlacrittyTheme()<CR>", silence)

-- windows
setmap("n", "<C-h>", ":wincmd h<CR>", silence)
setmap("n", "<C-j>", ":wincmd j<CR>", silence)
setmap("n", "<C-k>", ":wincmd k<CR>", silence)
setmap("n", "<C-l>", ":wincmd l<CR>", silence)
setmap("n", "<Leader>wo", ":on<CR>", silence)

-- resizing splits
setmap("n", "<Leader>wh", ":vertical resize -3<CR>", silence)
setmap("n", "<Leader>wj", ":resize -3<CR>", silence)
setmap("n", "<Leader>wk", ":resize +3<CR>", silence)
setmap("n", "<Leader>wl", ":vertical resize +3<CR>", silence)
setmap("n", "<Leader>w=", "<C-W>=", silence)

-- to do with files
-- setmap("n", "<Leader>fv", ":e $MYVIMRC<CR>", silence)
setmap("n", "<Leader>fj", ":w!<CR>", noremap)
setmap("n", "<Leader>fq", ":q", noremap)
setmap("n", "<Leader>v", ":luafile $MYVIMRC<CR>", noremap)

--Ctrl-Backspace will delete the word behind the cursor in --INSERT--
setmap("i", "<C-h>", "<C-O>b<C-O>dw", noremap)
