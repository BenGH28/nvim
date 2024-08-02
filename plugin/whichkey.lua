-- vim: foldmethod=marker
-- {{{ regular maps

-- alias the long function
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

setmap("n", "K", ":Lspsaga hover_doc<cr>", silence)

--terminal escape
--need to escape \ in the lua api
setmap("t", "<Esc>", "<C-\\><C-n>", noremap)

-- }}} regular

--{{{ which-key

local good, wk = pcall(require, "which-key")

if not good then
  return
end

--{{{ g mappings
local gmaps = {
  mode = "n",
  {
    "gd",
    vim.lsp.buf.definition,
    desc = "go to definition",
  },
  {
    "gi",
    vim.lsp.buf.implementation,
    desc = "go to implementation",
  },
  {
    "gr",
    vim.lsp.buf.references,
    desc = "go to references",
  },
  {
    "gj",
    require("mini.splitjoin").toggle,
    desc = "split join",
  },
  {
    "gn",
    ":Lspsaga rename<cr>",
    desc = "rename"
  },
}


wk.add(gmaps)
--}}} g


wk.add(
  {
    mode = 'n',
    { "<leader>bs",  group = "+substitute" },
    { "<leader>bsg", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "substitute word in file" },
    { "<leader>bsl", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],  desc = "substitute word in line" },
  }
)


wk.add({
  mode = 'n',
  { '<leader>.', ":tabn<cr>", desc = "next" },
  { '<leader>,', ":tabp<cr>", desc = "previous" }
}
)

wk.add({
  mode = 'n',
  { "<leader>b",  group = "+buffers" },
  { "leader>bn",  ":bnext<cr>",      desc = "next" },
  { "<leader>bp", ":bprev<cr>",      desc = "previous" },
  { "<leader>bd", ":Bdelete!<cr>",   desc = "delete" },
  {
    "<leader>bf",
    function()
      if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
        vim.lsp.buf.format { async = true }
      end
    end,
    desc = "format",
  },
})
wk.add {
  mode = "n",
  {
    "<leader>c",
    function()
      require("telescope.builtin").colorscheme({ enable_preview = true })
    end,
    desc = "colorschemes",
  }
}

wk.add({
  mode = "n",
  { "<leader>d",  group = "+docs" },
  { "<leader>dd", ":Dox<cr>",               desc = "Doxygen" },
  { "<leader>dk", ":Lspsaga hover_doc<cr>", desc = "hover doc" },
})

wk.add({
  mode = "n",
  { "<leader>f",  group = "+files" },
  { "<leader>ff", ":Telescope find_files<cr>",   desc = "find files" },
  { "<leader>fj", ":w!<cr>",                     desc = "write file" },
  { "<leader>f/", ":Telescope live_grep<cr>",    desc = "live grep" },
  { "<leader>fl", ":Telescope buffers<cr>",      desc = "buffers" },
  { "<leader>fb", ":Telescope file_browser<cr>", desc = "file browser" },
  {
    "<leader>f.",
    function()
      vim.cmd("source %")
      vim.notify("sourced " .. vim.fn.expand "%")
    end,
    desc = "source current file"
  },
  {
    "<leader>fs",
    require("common").scratch_buffer_below,
    desc = "scratch buffer",
  },
  {
    "<leader>fr",
    require("telescope.builtin").oldfiles,
    desc = "recent files",
  },
  {
    "<leader>fg",
    require("telescope.builtin").git_files,
    desc = "git files",
  },
  { "<leader>fp", ":Telescope projects<cr>", desc = "projects" },
})

wk.add({
  mode = "n",
  { "<leader>fv",  group = "+config" },
  {
    "<leader>fvm",
    function()
      require("common").edit_plugin_file "whichkey.lua"
    end,
    desc = "edit mappings",
  },
  {
    "<leader>fvn",
    function()
      require("go_to_plugins").configs({ netrw = true })
    end,
    desc = "goto neovim config in Netrw",
  },
  {
    "<leader>fvt",
    function()
      require("go_to_plugins").configs({ netrw = false })
    end,
    desc = "goto any neovim file using Telescope",
  },
  {
    "<leader>fvo",
    function()
      require("common").edit_lua_file "core/options"
    end,
    desc = "edit nvim options",
  },
  { "<leader>fvv", ":e $MYVIMRC<cr>", desc = "open init.lua" },
})

wk.add({
  mode = "n",
  { "<leader>g", group = "+git" },
  {
    "<leader>gs",
    require("gitsigns").stage_hunk,
    desc = "stage hunk",
  },
  {
    "<leader>gu",
    require("gitsigns").undo_stage_hunk,
    desc = "undo stage hunk",
  },
  {
    "<leader>gr",
    require("gitsigns").reset_hunk,
    desc = "reset hunk",
  },
  {
    "<leader>gR",
    require("gitsigns").reset_buffer,
    desc = "reset buffer",
  },
  {
    "<leader>gp",
    require("gitsigns").preview_hunk,
    desc = "preview hunk",
  },
  {
    "<leader>gb",
    require("gitsigns").blame_line,
    desc = "blame line",
  },
  {
    "<leader>gS",
    require("gitsigns").stage_buffer,
    desc = "stage buffer",
  },
  {
    "<leader>gU",
    require("gitsigns").reset_buffer_index,
    desc = "reset buffer index",
  },
})
wk.add({
  mode = "n",
  { "<leader>h", group = "+help" },
  {
    "<leader>hh",
    require("telescope.builtin").help_tags,
    desc = "help docs",
  },
  {
    "<leader>hm",
    require("telescope.builtin").man_pages,
    desc = "man pages",
  },
})

wk.add({
  mode = "n",
  { "<leader>l",  group = "+lsp" },
  { "<leader>lc", ":Lspsaga code_action<cr>", desc = "code action" },
  { "<leader>lo", ":Lspsaga outline<cr>",     desc = "outline" },
  { "<leader>li", ":LspInfo<cr>",             desc = "info" },
  { "<leader>ls", ":LspStart<cr>",            desc = "start" },
  { "<leader>lr", ":LspRestart<cr>",          desc = "restart" },
  { "<leader>lp", ":LspStop<cr>",             desc = "stop" },
})
wk.add({
  mode = "n",
  { "<leader>ld",  group = "+diagnostics" },
  { "<leader>ldd", ":Lspsaga show_line_diagnostics<cr>",      desc = "Show line diagnostics" },
  { "<leader>ldc", ":Lspsaga show_cursor_diagnostics<cr>",    desc = "Show cursor diagnostics" },
  { "<leader>ldn", ":Lspsaga diagnostic_jump_next<cr>",       desc = "Next diagnostic" },
  { "<leader>ldp", ":Lspsaga diagnostic_jump_prev<cr>",       desc = "Prev diagnostic" },
  { "<leader>ldw", ":Lspsaga show_workspace_diagnostics<cr>", desc = "workspace diagnostics" },
  { "<leader>ldb", ":Lspsaga show_buf_diagnostics<cr>",       desc = "buffer diagnostics" },
})
wk.add({
  mode = "n",
  { "<leader>lm",  group = "+mason" },
  { "<leader>lmm", ":Mason<cr>",       desc = "Dashboard" },
  { "<leader>lmi", ":MasonInstall",    desc = "Install" },
  { "<leader>lmu", ":MasonUpdate<cr>", desc = "Update" },
  { "<leader>lml", ":MasonLog<cr>",    desc = "Log" },
})
wk.add({
  mode = "n",
  { "<leader>ly", group = "+symbols" },
  {
    "<leader>lyw",
    require("telescope.builtin").lsp_workspace_symbols,
    desc = "workspace symbols",
  },
  {
    "<leader>lyd",
    require("telescope.builtin").lsp_document_symbols,
    desc = "document symbols",
  },
})
wk.add({
  mode = "n",
  { "<leader>lt",  group = "+trouble" },
  { "<leader>ltd", ":Trouble diagnostics<cr>",          desc = "diagnostics" },
  { "<leader>lty", ":Trouble lsp_document_symbols<cr>", desc = "document diagnostics" },
  { "<leader>ltq", ":Trouble quickfix<cr>",             desc = "quickfix" },
  { "<leader>ltl", ":Trouble loclist<cr>",              desc = "loclist" },
})
wk.add {
  mode = "n",
  { "<leader>n",  group = "+notifcations" },
  { "<leader>nn", ":Notifications<cr>",   desc = "notifcations" },
  {
    "<leader>nd",
    function()
      require("notify").dismiss { pending = true, silent = true }
    end,
    desc = "dismiss notifcations",
  },
}
wk.add {
  mode = "n",
  { "<leader>z",  group = "+Lazy", },
  { "<leader>zc", ":Lazy check<cr>",   desc = "check" },
  { "<leader>zi", ":Lazy install<cr>", desc = "install" },
  { "<leader>zl", ":Lazy log<cr>",     desc = "log" },
  { "<leader>zp", ":Lazy profile<cr>", desc = "profile" },
  { "<leader>zr", ":Lazy reload<cr>",  desc = "reload" },
  { "<leader>zs", ":Lazy sync<cr>",    desc = "sync" },
  { "<leader>zu", ":Lazy update<cr>",  desc = "update" },
  { "<leader>zC", ":Lazy clean<cr>",   desc = "clean" },
  { "<leader>zz", ":Lazy home<cr>",    desc = "home" },
}
wk.add {
  mode = "n",
  { "<leader>q",  group = "+quickfix" },
  { "<leader>qq", ":copen<cr>",       desc = "open" },
  { "<leader>qn", ":cnext<cr>",       desc = "next" },
  { "<leader>qp", ":cprevious<cr>",   desc = "previous" },
  { "<leader>qc", ":cclose<cr>",      desc = "close" },
}
wk.add {
  mode = "n",
  { "<leader>t", group = "+terminal" },
  { "<leader>tn",
    function()
      vim.cmd(":10 sp | terminal")
    end,
    desc = "new terminal" },
}
wk.add {
  mode = "n",
  { "<leader>w",  group = "+window" },
  { "<leader>wh", ":vertical resize -3<CR>", desc = "decrease width" },
  { "<leader>wj", ":resize -3<CR>",          desc = "decrease height" },
  { "<leader>wk", ":resize +3<CR>",          desc = "increase height" },
  { "<leader>wl", ":vertical resize +3<CR>", desc = "increase height" },
  { "<leader>wh", "<C-W>=<cr>",              desc = "balance" },
  { "<leader>wo", ":on<cr>",                 desc = "show only current window" },
  { "<leader>wv", ":vs<cr>",                 desc = "make vertical split" },
  { "<leader>ws", ":sp<cr>",                 desc = "make horizontal split" },
  {
    "<leader>wy",
    require("telescope.builtin").symbols,
    desc = "symbols",
  },
}
