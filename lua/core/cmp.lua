-- Setup nvim-cmp.
local cmp = require "cmp"


local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

-- local win_ui = { "Normal:Pmenu,FloatBorder:Pmenu,Search:None", col_offset = 1, side_padding = 0 }
local win_ui = cmp.config.window.bordered()
cmp.setup {
  view =
  {
    entries = {
      name = "custom",
      selection_order = "near_cursor",
    },
  },
  window = {
    completion = win_ui,
    documentation = win_ui,
  },
  preselect = cmp.PreselectMode.None,

  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },

  mapping = cmp.mapping.preset.insert {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-y>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  completion = {
    completeopt = "menu,menuone,noinsert",
    keyword_length = 1,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "buffer" },
    { name = "cmdline" },
    { name = "nvim_lsp_signature_help" },
    {
      name = "tmux",
      options = {
        all_panes = true,
        label = "[tmux]",
        trigger_characters = { "." },
        trigger_characters_ft = {}, -- { filetype = { '.' } }
      },
    },
  },
  sorting = {
    priority_weight = 100,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      require("cmp-under-comparator").under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    expandable_indicator = true,
    format = function(entry, vim_item)
      local exists, lspkind = pcall(require, "lspkind")
      local opts = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        vsnip = "[VSnip]",
        nvim_lua = "[NVIM]",
        latex_symbols = "[LaTeX]",
      }

      if not exists then
        -- Kind icons
        vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        -- Source
        vim_item.menu = (opts)[entry.source.name]
        return vim_item
      else
        return lspkind.cmp_format {
          mode = "text_symbol",
          menu = opts,
        } (entry, vim_item)
      end
    end,
  },
}
