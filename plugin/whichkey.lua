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
      t = {":call MyFunctions#Toggle_transparent_background()<cr>", "toggle transparency"}
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
      s = {"luafile $MYVIMRC<cr>", "reload vimrc"},
      o = {":e /home/ben/.config/nvim/lua/options.lua<cr>", "edit nvim options"},
      m = {":e /home/ben/.config/nvim/lua/general-mappings.lua<cr>", "edit non-leader mappings"},
      p = {":e /home/ben/.config/nvim/lua/plugins.lua<cr>", "edit plugins"}
    },
    e = {":Telescope file_browser<cr>", "find explorer"},
    f = {":Telescope find_files<cr>", "find files"},
    g = {":Telescope git_files<cr>", "git files"},
    ["/"] = {":Telescope live_grep<cr>", "search project"},
    h = {":Telescope oldfiles<cr>", "history"},
    j = {":w!<cr>", "save"},
    q = {":q<cr>", "quit"},
    ["."] = {":call MyFunctions#mysource()<cr>", "souce current file"}
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
    i = {":call MyFunctions#mysource() | PackerInstall<cr>", "install"},
    u = {":call MyFunctions#mysource() | PackerUpdate<cr>", "update"},
    c = {":call MyFunctions#mysource() | PackerClean<cr>", "clean"},
    C = {":call MyFunctions#mysource() | PackerCompile<cr>", "compile"},
    s = {":call MyFunctions#mysource() | PackerSync<cr>", "sync"},
    S = {":call MyFunctions#mysource() | PackerStatus<cr>", "status"}
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
    n = {":lua requre'trouble'.next({skip_groups = true, jump = true})<cr>", "next"},
    p = {":lua requre'trouble'.previous({skip_groups = true, jump = true})<cr>", "previous"}
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
