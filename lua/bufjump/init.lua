local BufJump = {}
BufJump.__index = {}

BufJump.ctx = {
  win_ids = {
    input = nil,
    buf_list = nil,
  },
}

BufJump._get_listed_bufs = function()
  local bufs = vim.tbl_filter(function(bufnr)
    return vim.api.nvim_buf_get_option(bufnr, "buflisted")
  end, vim.api.nvim_list_bufs())
  local map = {}
  for _, buf in pairs(bufs) do
    map[buf] = vim.api.nvim_buf_get_name(buf)
  end
  return map
end

BufJump._buflines = function(buftable)
  local lines = {}
  for k, v in pairs(buftable) do
    table.insert(lines, (k or 0) .. v)
  end
  return lines
end

function BufJump:_make_buffer_list_window()
  local bufnr = vim.api.nvim_create_buf(false, false)
  local bufs = self._get_listed_bufs()
  local width = 40
  local height = 10
  local config = {
    relative = "editor",
    row = math.floor((vim.o.lines / 2)) - height / 2,
    col = math.floor((vim.o.columns / 2)) - width / 2,
    width = width,
    height = height,
    border = "single",
    style = "minimal",
    title = "Buffers",
  }

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, self._buflines(bufs))
  local win = vim.api.nvim_open_win(bufnr, false, config)
  self.ctx.win_ids.buf_list = win
end

function BufJump:_make_input_window(col, row)
  local bufnr = vim.api.nvim_create_buf(false, false)

  local width = 40
  local height = 1
  local config = {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    border = "single",
    style = "minimal",
    title = "Select",
  }

  local win = vim.api.nvim_open_win(bufnr, true, config)
  self.ctx.win_ids.input = win
  vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
    buffer = bufnr,
    callback = function()
      local buf_list_win = self.ctx.win_ids.buf_list

      if buf_list_win and vim.api.nvim_win_is_valid(buf_list_win) then
        local the_buf = vim.api.nvim_win_get_buf(buf_list_win)
        vim.api.nvim_win_close(buf_list_win, true)
        vim.api.nvim_buf_delete(the_buf, { force = true })
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end

      self.ctx.win_ids.buf_list = nil
      self.ctx.win_ids.input = nil
    end,
  })
end

function BufJump:jump()
  self:_make_buffer_list_window()

  local conf = vim.api.nvim_win_get_config(self.ctx.win_ids.buf_list)
  self:_make_input_window(conf.col, conf.row - 3)
end

BufJump:jump()
