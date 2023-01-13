local barbecue = require 'barbecue'

local icons = {
  File = " ",
  Module = " ",
  Namespace = " ",
  Package = " ",
  Class = " ",
  Method = " ",
  Property = " ",
  Field = " ",
  Constructor = " ",
  Enum = "練",
  Interface = "練",
  Function = " ",
  Variable = " ",
  Constant = " ",
  String = " ",
  Number = " ",
  Boolean = "◩ ",
  Array = " ",
  Object = " ",
  Key = " ",
  Null = "ﳠ ",
  EnumMember = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
}

barbecue.setup({
  --whether to create winbar updater autocmd
  ---@type boolean
  create_autocmd = true,

  ---buftypes to enable winbar in
  ---@type table
  include_buftypes = { "" },

  ---filetypes not to enable winbar in
  ---@type table
  exclude_filetypes = { "alpha", "terminal", "NvimTree", "toggleterm" },

  ---returns a string to be shown at the end of winbar
  ---@param bufnr number
  ---@return string
  custom_section = function(bufnr)
    return ""
  end,

  ---:help filename-modifiers
  modifiers = {
    ---@type string
    dirname = ":~:.",

    ---@type string
    basename = "",
  },

  symbols = {
    ---string to be shown at the start of winbar
    ---@type string
    prefix = "",

    ---entry separator
    ---@type string
    separator = '',

    ---string to be shown when buffer is modified
    ---@type string
    modified = "[+]",

    ---string to be shown when context is available but empty
    ---@type string
    default_context = "…",
  },

  ---icons for different context entry kinds
  kinds = icons,
})
