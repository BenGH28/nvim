local show = function(lines)
  local default_size = 0.85
  local win_height = math.floor(vim.api.nvim_win_get_height(0) * default_size)
  local win_width = math.floor(vim.api.nvim_win_get_width(0) * default_size)

  local height = vim.api.nvim_win_get_height(0)
  local width = vim.api.nvim_win_get_width(0)
  local row = (height - win_height) / 2 - 1
  local col = (width - win_width) / 2

  local config = {
    relative = "editor",
    row = row,
    col = col,
    width = win_width,
    height = win_height,
    border = "rounded",
    style = "minimal",
  }


  local bufnr = vim.api.nvim_create_buf(true, true)
  local win_id = vim.api.nvim_open_win(bufnr, true, config)
  vim.api.nvim_set_current_win(win_id)
  vim.api.nvim_buf_set_option(bufnr, "ft", "python")

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end



-- Fallback for utf8.char
local function unicode_char(codepoint)
  if codepoint <= 0x7F then
    return string.char(codepoint)
  elseif codepoint <= 0x7FF then
    return string.char(
      0xC0 + math.floor(codepoint / 0x40),
      0x80 + (codepoint % 0x40)
    )
  elseif codepoint <= 0xFFFF then
    return string.char(
      0xE0 + math.floor(codepoint / 0x1000),
      0x80 + (math.floor(codepoint / 0x40) % 0x40),
      0x80 + (codepoint % 0x40)
    )
  elseif codepoint <= 0x10FFFF then
    return string.char(
      0xF0 + math.floor(codepoint / 0x40000),
      0x80 + (math.floor(codepoint / 0x1000) % 0x40),
      0x80 + (math.floor(codepoint / 0x40) % 0x40),
      0x80 + (codepoint % 0x40)
    )
  else
    error("Invalid Unicode codepoint: " .. codepoint)
  end
end



local decode = function(str)
  str = str:gsub("\\t", "\t")

  -- Replace \" with "
  str = str:gsub('\\"', '"')

  return str:gsub("\\u(%x%x%x%x)", function(hex)
    return unicode_char(tonumber(hex, 16))
  end)
end



vim.keymap.set("n", "<leader>s", function()
  local line = vim.api.nvim_get_current_line()
  local decoded = decode(line)
  local splits = vim.split(decoded, ":")

  table.remove(splits, 1)
  local subbed = table.concat(splits, ":")
  subbed = subbed:sub(3, -3)

  local lines = vim.split(subbed, "\\n")
  show(lines)
end, { buffer = 0 })
