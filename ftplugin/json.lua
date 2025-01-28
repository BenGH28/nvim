vim.bo.shiftwidth = 2
vim.bo.tabstop = 2

local show = function(lines)
  local default_size = 0.85
  local win_height = math.floor(#lines + 3)
  local win_width = math.floor(vim.api.nvim_win_get_width(0) * default_size)
  local cursor = vim.api.nvim_win_get_cursor(0)

  local height = vim.api.nvim_win_get_height(0)
  local width = vim.api.nvim_win_get_width(0)
  local row = (height - win_height) / 2 - 1
  local col = (width - win_width) / 2

  local config = {
    relative = "editor",
    row = cursor[1],
    col = cursor[2],
    width = win_width,
    height = win_height,
    border = "rounded",
    style = "minimal",
  }


  local bufnr = vim.api.nvim_create_buf(true, true)
  local win_id = vim.api.nvim_open_win(bufnr, true, config)
  vim.api.nvim_set_current_win(win_id)

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

  vim.api.nvim_buf_set_option(bufnr, "ft", "python")
  vim.api.nvim_buf_set_option(bufnr, "number", true)
  vim.api.nvim_buf_set_option(bufnr, "modifiable", false)

  vim.keymap.set("n", "qq", function()
    vim.api.nvim_buf_delete(bufnr, {})
  end, { buffer = true, desc = "close script window" })
end

local decode = function(str)
  str = str:gsub("\\t", "\t")

  -- Replace \" with "
  str = str:gsub('\\"', '"')

  return str:gsub("\\u(%x%x%x%x)", function(hex)
    return vim.fn.nr2char(tonumber(hex, 16))
  end)
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "view.json",
  callback = function()
    vim.keymap.set("n", "<leader>s", function()
      local line = vim.api.nvim_get_current_line()
      local decoded = decode(line)
      local splits = vim.split(decoded, ":")

      table.remove(splits, 1)
      local subbed = table.concat(splits, ":")
      subbed = subbed:sub(3, -2):gsub('"$', ""):gsub("%s+$", "")

      local lines = vim.split(subbed, "\\n")
      show(lines)
    end, { buffer = true, desc = "open script window" })
  end
})
