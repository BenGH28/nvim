-- vim: foldmethod=marker
-- {{{ regular maps

-- alias the long function
local setmap = vim.api.nvim_set_keymap

-- move you selections in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

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
  l = { ":HopLine<cr>", "hop line" },
  p = { ":HopPattern<cr>", "hop pattern" },
  w = { ":HopWord<cr>", "hop word" },
  d = {
    function()
      vim.lsp.buf.definition()
    end,
    "go to definition",
  },
  I = {
    function()
      vim.lsp.buf.implementation()
    end,
    "go to implementation",
  },
  r = {
    function()
      vim.lsp.buf.references()
    end,
    "go to references",
  },
  s = {
    function()
      require("mini.splitjoin").toggle()
    end,
    "split join",
  },
  h = { ":Lspsaga finder<cr>", "lsp finder" },
  n = { ":Lspsaga rename<cr>", "rename" },
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
  ["1"] = { ":BufferLineGoToBuffer 1<cr>", "Goto buffer 1" },
  ["2"] = { ":BufferLineGoToBuffer 2<cr>", "Goto buffer 2" },
  ["3"] = { ":BufferLineGoToBuffer 3<cr>", "Goto buffer 3" },
  ["4"] = { ":BufferLineGoToBuffer 4<cr>", "Goto buffer 4" },
  ["5"] = { ":BufferLineGoToBuffer 5<cr>", "Goto buffer 5" },
  ["6"] = { ":BufferLineGoToBuffer 6<cr>", "Goto buffer 6" },
  ["7"] = { ":BufferLineGoToBuffer 7<cr>", "Goto buffer 7" },
  ["8"] = { ":BufferLineGoToBuffer 8<cr>", "Goto buffer 8" },
  ["9"] = { ":BufferLineGoToBuffer 9<cr>", "Goto buffer 9" },
  b = {
    name = "+buffers",
    n = { ":BufferLineCycleNext<cr>", "next" },
    p = { ":BufferLineCyclePrev<cr>", "previous" },
    d = { ":Bdelete!<cr>", "delete" },
    f = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "format",
    },
    l = {
      function()
        require("telescope.builtin").buffers()
      end,
      "list buffers",
    },
    t = {
      function()
        require("mini.trailspace").trim()
      end,
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
      function()
        require("telescope.builtin").find_files()
      end,
      "find files",
    },
    g = {
      function()
        require("telescope.builtin").git_files()
      end,
      "git files",
    },
    ["/"] = {
      function()
        require("telescope.builtin").live_grep()
      end,
      "search project",
    },
    h = {
      function()
        require("telescope.builtin").oldfiles()
      end,
      "history",
    },
    j = { ":w!<cr>", "save" },
    q = { ":q<cr>", "quit" },
    p = { ":Telescope projects<cr>", "projects" },
    s = {
      function()
        require("common").scratch_buffer_below()
      end,
      "scratch buffer",
    },
    ["."] = { ":source % | lua vim.notify('file sourced')<cr>", "source current file" },
  },
  g = {
    name = "+git",
    l = { ":LazyGit<cr>", "lazygit" },
    s = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "stage hunk",
    },
    u = {
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      "undo stage hunk",
    },
    r = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "reset hunk",
    },
    R = {
      function()
        require("gitsigns").reset_buffer()
      end,
      "reset buffer",
    },
    p = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "preview hunk",
    },
    b = {
      function()
        require("gitsigns").blame_line()
      end,
      "blame line",
    },
    S = {
      function()
        require("gitsigns").stage_buffer()
      end,
      "stage buffer",
    },
    U = {
      function()
        require("gitsigns").reset_buffer_index()
      end,
      "reset buffer index",
    },
  },
  h = {
    name = "+help",
    h = {
      function()
        require("telescope.builtin").help_tags()
      end,
      "help docs",
    },
    m = {
      function()
        require("telescope.builtin").man_pages()
      end,
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
        function()
          require("telescope.builtin").lsp_workspace_symbols()
        end,
        "workspace symbols",
      },
      d = {
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
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
      z = { ":Lazy home<cr>", "home" },
      i = { ":Lazy install<cr>", "install" },
      u = { ":Lazy update<cr>", "update" },
      c = { ":Lazy check<cr>", "check" },
      p = { ":Lazy profile<cr>", "profile" },
      l = { ":Lazy log<cr>", "log" },
      x = { ":Lazy clean<cr>", "clean" },
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
      function()
        require("persistence").load {}
      end,
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
        require("persistence").stop {}
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
    function()
      require("telescope.builtin").symbols()
    end,
    "+symbols",
  },
}

wk.register(silent_normal_maps, silent_normal_opts)
--}}} silent

--}}} normals

--}}} which-key
