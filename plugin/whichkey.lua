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

-- =============================================================
-- non-leader mappings
-- =============================================================

local wk = require "which-key"

local nopts = {
  prefix = "<Leader>"
}
local nmappings = {
  ["."] = {":tabn<cr>", "next"},
  [","] = {":tabp<cr>", "previous"},
  ["1"] = {":BufferLineGoToBuffer 1<cr>", "Goto buffer 1"},
  ["2"] = {":BufferLineGoToBuffer 2<cr>", "Goto buffer 2"},
  ["3"] = {":BufferLineGoToBuffer 3<cr>", "Goto buffer 3"},
  ["4"] = {":BufferLineGoToBuffer 4<cr>", "Goto buffer 4"},
  ["5"] = {":BufferLineGoToBuffer 5<cr>", "Goto buffer 5"},
  ["6"] = {":BufferLineGoToBuffer 6<cr>", "Goto buffer 6"},
  ["7"] = {":BufferLineGoToBuffer 7<cr>", "Goto buffer 7"},
  ["8"] = {":BufferLineGoToBuffer 8<cr>", "Goto buffer 8"},
  ["9"] = {":BufferLineGoToBuffer 9<cr>", "Goto buffer 9"},
  b = {
    name = "+buffers",
    n = {":bNext<cr>", "next"},
    p = {":bprevious", "previous"},
    h = {
      name = "+hop",
      w = {":HopWord<cr>", "word"},
      l = {":HopLine<cr>", "line"},
      p = {":HopPattern<cr>", "pattern"}
    },
    d = {":bdelete<cr>", "delete"},
    l = {":Telescope buffers<cr>", "list buffers"},
    s = {
      name = "+substitute",
      g = {[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "global word substitute"},
      l = {[[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "local word substitute"}
    },
    b = {
      name = "+background",
      l = {":set background=light<cr>", "light"},
      d = {":set background=dark<cr>", "dark"},
      m = {":call MyFunctions#ToggleAlacrittyTheme()<cr>", "match alacritty"},
      t = {":call MyFunctions#ToggleTransparentBackground()<cr>", "toggle transparency"}
    }
  },
  d = {":Dox<cr>", "Doxygen"},
  f = {
    name = "+files",
    o = {":Format<cr>", "format"},
    v = {
      name = "+nvim config",
      v = {":e $MYVIMRC<cr>", "open init.lua"},
      -- not sure this binding does anything (major) now
      s = {":so $MYVIMRC<cr>", "reload vimrc"},
      o = {":lua require'common'.edit_lua_file('options')<cr>", "edit nvim options"},
      p = {":lua require'common'.edit_lua_file('plugins')<cr>", "edit plugins"},
      m = {":lua require'common'.edit_plugin_file('whichkey.lua')<cr>", "edit mappings"}
    },
    e = {":Telescope file_browser<cr>", "find explorer"},
    f = {":Telescope find_files<cr>", "find files"},
    g = {":Telescope git_files<cr>", "git files"},
    ["/"] = {":Telescope live_grep<cr>", "search project"},
    h = {":Telescope oldfiles<cr>", "history"},
    j = {":w!<cr>", "save"},
    q = {":q<cr>", "quit"},
    ["."] = {":so %<cr>", "source current file"}
  },
  g = {
    name = "+git",
    l = {":LazyGit<cr>", "lazygit"},
    s = {":lua require'gitsigns'.stage_hunk()<cr>", "stage hunk"},
    u = {":lua require'gitsigns'.undo_stage_hunk()<cr>", "undo stage hunk"},
    r = {":lua require'gitsigns'.reset_hunk()<cr>", "reset hunk"},
    R = {":lua require'gitsigns'.reset_buffer()<cr>", "reset buffer"},
    p = {":lua require'gitsigns'.preview_hunk()<cr>", "preview hunk"},
    b = {":lua require'gitsigns'.blame_line()<cr>", "blame line"},
    S = {":lua require'gitsigns'.stage_buffer()<cr>", "stage buffer"},
    U = {":lua require'gitsigns'.reset_buffer_index()<cr>", "reset buffer index"}
  },
  h = {
    name = "+help",
    h = {":Telescope help_tags<cr>", "help docs"},
    m = {":Telescope man_pages<cr>", "man pages"}
  },
  l = {
    name = "+lsp",
    c = {":Lspsaga code_action<cr>", "code action"},
    d = {
      name = "+diagnostics",
      l = {":Lspsaga show_line_diagnostics<cr>", "Show line diagnostics"},
      c = {":Lspsaga show_cursor_diagnostics", "Show cursor diagnostics"},
      n = {":Lspsaga diagnostic_jump_next", "Next diagnostic"},
      p = {":Lspsaga diagnostic_jump_prev", "Prev diagnostic"},
      q = {"lua vim.lsp.diagnostic.set_loclist()", "Diagnostic list"}
    },
    f = {
      name = "+folder",
      a = {"lua vim.lsp.buf.add_workspace_folder()", "Add workspace folder"},
      r = {"lua vim.lsp.buf.remove_workspace_folder()", "Remove workspace folder"},
      l = {"lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))", "List workspace folders"}
    },
    l = {":LspInfo", "info"}
  },
  p = {
    name = "+packer",
    i = {":lua require'common'.install_plugins()<cr>", "install"},
    u = {":lua require'common'.update_plugins()<cr>", "update"},
    c = {":lua require'common'.clean_plugins()<cr>", "clean"},
    C = {":lua require'comon'.compile_plugins()<cr>", "compile"},
    s = {":lua require'common'.sync_plugins()<cr>", "sync"},
    S = {":lua require'common'.packer_status()<cr>", "status"}
  },
  q = {
    name = "+quickfix",
    n = {":cnext<cr>", "next"},
    p = {":cprevious<cr>", "previous"},
    c = {":cclose<cr>", "close"}
  },
  s = {
    name = "+sessions",
    c = {":lua require'persistence'.load{}<cr>", "load current directory session"},
    l = {":lua require'persistence'.load{last = true}<cr>", "load last session"},
    s = {":lua require'persistence'.stop{}<cr>", "stop"}
  },
  t = {
    name = "+trouble",
    x = {":TroubleToggle<cr>", "toggle"},
    w = {":TroubleToggle lsp_workspace_diagnostics<cr>", "workspace diagnostics"},
    d = {":TroubleToggle lsp_document_diagnostics<cr>", "document diagnostics"},
    q = {":TroubleToggle quickfix<cr>", "quickfix"},
    l = {":TroubleToggle loclist<cr>", "loclist"},
    n = {":lua require'trouble'.next({skip_groups = true, jump = true})<cr>", "next"},
    p = {":lua require'trouble'.previous({skip_groups = true, jump = true})<cr>", "previous"}
  },
  w = {
    name = "+window",
    h = {":vertical resize -3<CR>", "decrease width"},
    j = {":resize -3<CR>", "decrease height"},
    k = {":resize +3<CR>", "increase height"},
    l = {":vertical resize +3<CR>", "increase height"},
    ["="] = {"<C-W>=<cr>", "balance"},
    o = {":on<cr>", "show only current window"},
    v = {":vs<cr>", "make vertical split"},
    s = {":sp<cr>", "make horizontal split"}
  }
}

wk.register(nmappings, nopts)
