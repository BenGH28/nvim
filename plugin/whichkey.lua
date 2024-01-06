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

setmap("n", "<C-n>", ":NvimTreeToggle<CR>", silence)

setmap("n", "Y", "y$", noremap)
setmap("n", "0", "0^", noremap)

-- windows
setmap("n", "<C-h>", ":wincmd h<CR>", silence)
setmap("n", "<C-j>", ":wincmd j<CR>", silence)
setmap("n", "<C-k>", ":wincmd k<CR>", silence)
setmap("n", "<C-l>", ":wincmd l<CR>", silence)

-- think of J but for K... very obvious I know
setmap("n", "K", "Dk$p", silence)

--terminal escape
--need to escape \ in the lua api
setmap("t", "<Esc>", "<C-\\><C-n>", noremap)

-- }}} regular

--{{{ which-key

local good, wk = pcall(require, "which-key")

if not good then
  return
end

wk.setup {
  layout = {
    align = "center",
  },
}
--{{{ g mappings
local gmaps = {
  d = {
    vim.lsp.buf.definition,
    "go to definition",
  },
  I = {
    vim.lsp.buf.implementation(),
    "go to implementation",
  },
  r = {
    vim.lsp.buf.references,
    "go to references",
  },
  s = {
    require("mini.splitjoin").toggle,
    "split join",
  },
  n = {
    vim.lsp.buf.rename,
    "rename"
  },
}

local g_opts = {
  prefix = "g",
}

wk.register(gmaps, g_opts)
--}}} g

--{{{normal mappings

--{{{loud normal mappings
local loud_normal_maps = {
  b = {
    s = {
      name = "+substitute",
      g = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "substitute word in file" },
      l = { [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "substitute word in line" },
      -- need to register this here other wise it will have a silent mapping which then won't appear in the cmdline area until user types
    },
  },
}
local loud_normal_opts = {
  silent = false,
  prefix = "<Leader>",
}

wk.register(loud_normal_maps, loud_normal_opts)
--}}} loud

--{{{ silent normal mappings

local silent_normal_opts = {
  prefix = "<Leader>",
  mode = "n",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local silent_normal_maps = {
  ["."] = { ":tabn<cr>", "next" },
  [","] = { ":tabp<cr>", "previous" },
  b = {
    name = "+buffers",
    n = { ":bnext<cr>", "next" },
    p = { ":bprev<cr>", "previous" },
    d = { ":Bdelete!<cr>", "delete" },
    f = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "format",
    },
    t = {
      require("mini.trailspace").trim,
      "trim whitespace",
    },
    b = {
      name = "+background",
      l = { ":set background=light<cr>", "light" },
      d = { ":set background=dark<cr>", "dark" },
    },
  },
  d = {
    name = "+docs",
    d = { ":Dox<cr>", "Doxygen" },
    k = { ":Lspsaga hover_doc<cr>", "hover doc" },
  },
  f = {
    name = "+files",
    v = {
      name = "+nvim config",
      v = { ":e $MYVIMRC<cr>", "open init.lua" },
      -- not sure this binding does anything (major) now
      s = { ":so $MYVIMRC<cr>", "reload vimrc" },
      o = {
        function()
          require("common").edit_lua_file "core/options"
        end,
        "edit nvim options",
      },
      m = {
        function()
          require("common").edit_plugin_file "whichkey.lua"
        end,
        "edit mappings",
      },
    },
    f = {
      require("telescope.builtin").find_files,
      "find files",
    },
    l = {
      require("telescope.builtin").buffers,
      "buffers",
    },
    g = {
      require("telescope.builtin").git_files,
      "git files",
    },
    ["/"] = {
      require("telescope.builtin").live_grep,
      "search project",
    },
    h = {
      require("telescope.builtin").oldfiles,
      "history",
    },
    j = { ":w!<cr>", "save" },
    q = { ":q<cr>", "quit" },
    p = { ":Telescope projects<cr>", "projects" },
    s = {
      require("common").scratch_buffer_below,
      "scratch buffer",
    },
    ["."] = { ":source % | lua vim.notify('file sourced')<cr>", "source current file" },
  },
  g = {
    name = "+git",
    s = {
      require("gitsigns").stage_hunk,
      "stage hunk",
    },
    u = {
      require("gitsigns").undo_stage_hunk,
      "undo stage hunk",
    },
    r = {
      require("gitsigns").reset_hunk,
      "reset hunk",
    },
    R = {
      require("gitsigns").reset_buffer,
      "reset buffer",
    },
    p = {
      require("gitsigns").preview_hunk,
      "preview hunk",
    },
    b = {
      require("gitsigns").blame_line,
      "blame line",
    },
    S = {
      require("gitsigns").stage_buffer,
      "stage buffer",
    },
    U = {
      require("gitsigns").reset_buffer_index,
      "reset buffer index",
    },
  },
  h = {
    name = "+help",
    h = {
      require("telescope.builtin").help_tags,
      "help docs",
    },
    m = {
      require("telescope.builtin").man_pages,
      "man pages",
    },
  },
  l = {
    name = "+lsp",
    c = { ":Lspsaga code_action<cr>", "code action" },
    d = {
      name = "+diagnostics",
      l = { ":Lspsaga show_line_diagnostics<cr>", "Show line diagnostics" },
      c = { ":Lspsaga show_cursor_diagnostics<cr>", "Show cursor diagnostics" },
      n = { ":Lspsaga diagnostic_jump_next<cr>", "Next diagnostic" },
      p = { ":Lspsaga diagnostic_jump_prev<cr>", "Prev diagnostic" },
      w = { ":Lspsaga show_workspace_diagnostics<cr>", "workspace diagnostics" },
      b = { ":Lspsaga show_buf_diagnostics<cr>", "buffer diagnostics" },
    },
    m = {
      name = "+mason",
      m = { ":Mason<cr>", "Mason Dashboard" },
    },
    y = {
      name = "+symbols",
      w = {
        require("telescope.builtin").lsp_workspace_symbols,
        "workspace symbols",
      },
      d = {
        require("telescope.builtin").lsp_document_symbols,
        "document symbols",
      },
    },
    t = {
      name = "+trouble",
      x = { ":TroubleToggle<cr>", "toggle" },
      w = { ":TroubleToggle workspace_diagnostics<cr>", "workspace diagnostics" },
      d = { ":TroubleToggle document_diagnostics<cr>", "document diagnostics" },
      q = { ":TroubleToggle quickfix<cr>", "quickfix" },
      l = { ":TroubleToggle loclist<cr>", "loclist" },
      n = {
        function()
          require("trouble").next { skip_groups = true, jump = true }
        end,
        "next",
      },
      p = {
        function()
          require("trouble").previous { skip_groups = true, jump = true }
        end,
        "previous",
      },
    },
    o = { ":Lspsaga outline<cr>", "outline" },
    l = { ":LspInfo<cr>", "info" },
    s = { ":LspStart<cr>", "start" },
    r = { ":LspRestart<cr>", "restart" },
  },
  n = {
    name = "+notifcations",
    n = { ":Notifications<cr>", "notifcations" },
    d = {
      function()
        require("notify").dismiss { pending = true, silent = true }
      end,
      "dismiss notifcations",
    },
  },
  p = {
    name = "+plugins",
    e = {
      name = "+edit",
      p = {
        function()
          require("go_to_plugins"):plugins()
        end,
        "edit plugin spec",
      },
      c = {
        function()
          require("go_to_plugins"):configs()
        end,
        "edit plugin config",
      },
    },
    z = {
      name = "+Lazy",
      c = { ":Lazy check<cr>", "check" },
      i = { ":Lazy install<cr>", "install" },
      l = { ":Lazy log<cr>", "log" },
      p = { ":Lazy profile<cr>", "profile" },
      r = { ":Lazy reload<cr>", "reload" },
      s = { ":Lazy sync<cr>", "sync" },
      u = { ":Lazy update<cr>", "update" },
      x = { ":Lazy clean<cr>", "clean" },
      z = { ":Lazy home<cr>", "home" },
    },
  },
  q = {
    name = "+quickfix",
    n = { ":cnext<cr>", "next" },
    p = { ":cprevious<cr>", "previous" },
    c = { ":cclose<cr>", "close" },
  },
  s = {
    name = "+sessions",
    c = {
      require("persistence").load,
      "load current directory session",
    },
    l = {
      function()
        require("persistence").load { last = true }
      end,
      "load last session",
    },
    s = {
      function()
        require("persistence").stop()
      end,
      "stop",
    },
  },
  t = {
    name = "+terminal",
    n = { ":10 sp | terminal<cr>", "new terminal" },
  },
  w = {
    name = "+window",
    h = { ":vertical resize -3<CR>", "decrease width" },
    j = { ":resize -3<CR>", "decrease height" },
    k = { ":resize +3<CR>", "increase height" },
    l = { ":vertical resize +3<CR>", "increase height" },
    ["="] = { "<C-W>=<cr>", "balance" },
    o = { ":on<cr>", "show only current window" },
    v = { ":vs<cr>", "make vertical split" },
    s = { ":sp<cr>", "make horizontal split" },
  },
  y = {
    require("telescope.builtin").symbols,
    "+symbols",
  },
}

wk.register(silent_normal_maps, silent_normal_opts)
--}}} silent

--}}} normals

--}}} which-key
