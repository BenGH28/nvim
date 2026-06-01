local M = {}

local state = {
  buf      = nil,
  win      = nil,
  src_buf  = nil,
  src_win  = nil,
  symbols  = nil,
  flat     = nil,
  expanded = {},
}

local ns = vim.api.nvim_create_namespace("SymbolOutline")

local kind_hl = {
  [1]  = "Normal",           -- File
  [2]  = "@module",          -- Module
  [3]  = "@module",          -- Namespace
  [4]  = "@module",          -- Package
  [5]  = "@type",            -- Class
  [6]  = "@function.method", -- Method
  [7]  = "@variable.member", -- Property
  [8]  = "@variable.member", -- Field
  [9]  = "@constructor",     -- Constructor
  [10] = "@type",            -- Enum
  [11] = "@type",            -- Interface
  [12] = "@function",        -- Function
  [13] = "@variable",        -- Variable
  [14] = "@constant",        -- Constant
  [15] = "@string",          -- String
  [16] = "@number",          -- Number
  [17] = "@boolean",         -- Boolean
  [18] = "@type",            -- Array
  [19] = "@type",            -- Object
  [20] = "@variable.member", -- Key
  [21] = "Comment",          -- Null
  [22] = "@constant",        -- EnumMember
  [23] = "@type",            -- Struct
  [24] = "@type",            -- Event
  [25] = "@operator",        -- Operator
  [26] = "@type",            -- TypeParameter
}

local kind_icons = {
  [1] = "󰈙",
  [2] = "󰌗",
  [3] = "󰌗",
  [4] = "󰏗",
  [5] = "󰌗",
  [6] = "󰆧",
  [7] = "󰀫",
  [8] = "󰀫",
  [9] = "󰊕",
  [10] = "󰕘",
  [11] = "󰕘",
  [12] = "󰊕",
  [13] = "󰫧",
  [14] = "󰏿",
  [15] = "󰀬",
  [16] = "󰎠",
  [17] = "󰨙",
  [18] = "󰅪",
  [19] = "󰅩",
  [20] = "󰌋",
  [21] = "󰟢",
  [22] = "󰕘",
  [23] = "󰌗",
  [24] = "󰉺",
  [25] = "󰆕",
  [26] = "󰊄",
}

local function flatten(symbols, depth, result, parent_key)
  for i, sym in ipairs(symbols) do
    local has_children = sym.children ~= nil and #sym.children > 0
    local key = parent_key .. ":" .. sym.name .. ":" .. i
    table.insert(result, { sym = sym, depth = depth, has_children = has_children, key = key })
    if has_children and state.expanded[key] then
      flatten(sym.children, depth + 1, result, key)
    end
  end
end

local function render()
  if not (state.buf and vim.api.nvim_buf_is_valid(state.buf)) then return end

  state.flat = {}
  flatten(state.symbols or {}, 0, state.flat, "")

  local lines = {}
  for _, node in ipairs(state.flat) do
    local indent = string.rep("  ", node.depth)
    local marker = node.has_children and (state.expanded[node.key] and "▼ " or "▶ ") or "  "
    local icon   = (kind_icons[node.sym.kind] or "?") .. " "
    table.insert(lines, indent .. marker .. icon .. node.sym.name)
  end

  vim.bo[state.buf].modifiable = true
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
  vim.bo[state.buf].modifiable = false

  vim.api.nvim_buf_clear_namespace(state.buf, ns, 0, -1)
  for i, node in ipairs(state.flat) do
    local hl = kind_hl[node.sym.kind]
    if hl then
      vim.hl.range(state.buf, ns, hl, { i - 1, 0 }, { i - 1, -1 })
    end
  end
end

local function jump()
  local row  = vim.api.nvim_win_get_cursor(state.win)[1]
  local node = state.flat and state.flat[row]
  if not node then return end
  local r = (node.sym.selectionRange or node.sym.range).start
  vim.api.nvim_set_current_win(state.src_win)
  vim.api.nvim_win_set_cursor(state.src_win, { r.line + 1, r.character })
  vim.cmd("normal! zz")
end

local function toggle_node()
  local row  = vim.api.nvim_win_get_cursor(state.win)[1]
  local node = state.flat and state.flat[row]
  if not (node and node.has_children) then return end
  -- true = expanded, nil = collapsed
  state.expanded[node.key] = not state.expanded[node.key] or nil
  render()
  vim.api.nvim_win_set_cursor(state.win, { math.min(row, #state.flat), 0 })
end

local function collapse_all()
  state.expanded = {}
  render()
end

local function expand_all()
  local function expand_recursive(symbols, parent_key)
    for i, sym in ipairs(symbols) do
      local key = parent_key .. ":" .. sym.name .. ":" .. i
      if sym.children and #sym.children > 0 then
        state.expanded[key] = true
        expand_recursive(sym.children, key)
      end
    end
  end
  expand_recursive(state.symbols or {}, "")
  render()
end

local function close()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end
  state.win = nil
  state.buf = nil
end

local function open_win()
  state.buf                   = vim.api.nvim_create_buf(false, true)
  vim.bo[state.buf].bufhidden = "wipe"
  vim.bo[state.buf].filetype  = "SymbolOutline"

  vim.cmd("botright 40vsplit")
  state.win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(state.win, state.buf)
  vim.api.nvim_set_option_value("winfixwidth", true, { win = state.win })

  vim.wo[state.win].cursorline     = true
  vim.wo[state.win].wrap           = false
  vim.wo[state.win].number         = false
  vim.wo[state.win].relativenumber = false
  vim.wo[state.win].signcolumn     = "no"
  vim.wo[state.win].fillchars      = "eob: "

  local function map(lhs, fn)
    vim.keymap.set("n", lhs, fn, { buffer = state.buf, noremap = true, silent = true })
  end
  map("<CR>", jump)
  map("<Space>", toggle_node)
  map("o", toggle_node)
  map("q", close)
  map("<Esc>", close)
  map("C", collapse_all)
  map("E", expand_all)

  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer   = state.buf,
    once     = true,
    callback = function()
      state.win = nil; state.buf = nil
    end,
  })

  vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
    buffer   = state.src_buf,
    once     = true,
    callback = function() close() end,
  })
end

function M.toggle()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    close(); return
  end

  state.src_buf  = vim.api.nvim_get_current_buf()
  state.src_win  = vim.api.nvim_get_current_win()
  state.expanded = {}

  local params   = { textDocument = vim.lsp.util.make_text_document_params() }
  vim.lsp.buf_request(state.src_buf, "textDocument/documentSymbol", params, function(err, result)
    if err or not result or #result == 0 then
      vim.notify(err and err.message or "No symbols found", vim.log.levels.WARN)
      return
    end
    state.symbols = result
    open_win()
    render()
  end)
end

return M
