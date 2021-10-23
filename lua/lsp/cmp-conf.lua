-- Setup nvim-cmp.
local cmp = require "cmp"

cmp.setup(
  {
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end
    },
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
      ["<C-p>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
      ["<Down>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
      ["<Up>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm(
        {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true
        }
      )
    },
    sources = {
      {name = "nvim_lsp"},
      {name = "vsnip"},
      {name = "nvim_lua"},
      {name = "path"},
      {name = "buffer", keyword_length = 5}
    },
    completion = {
      keyword_length = 5
    },
    experimental = {
      native_menu = false,
      ghost_text = true
    },
    formatting = {
      format = require("lspkind").cmp_format(
        {
          with_text = true,
          menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            vsnip = "[VSnip]",
            nvim_lua = "[Lua]"
          })
        }
      )
    }
  }
)
