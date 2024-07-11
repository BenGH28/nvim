local lualine = require "lualine"

local lsp_component = {
  function()
    local msg = ""
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if next(clients) == nil then
      return msg
    end

    local names = {}
    for _, client in pairs(clients) do
      table.insert(names, client.name)
    end
    if next(names) then
      table.sort(names, function(left, right)
        return left < right
      end)
      return '{' .. table.concat(names, ',') .. '}'
    end
    return msg
  end,
  icon = '',
}


lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { { 'branch', icon = '󰊢' }, 'diff', 'diagnostics' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { lsp_component, 'fileformat', 'filetype', },
    lualine_y = { 'progress', },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
