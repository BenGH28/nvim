local saga = require("lspsaga")
saga.setup({
  symbols_in_winbar = {
    enable = true,
  },
  use_saga_diagnostic_sign = true,
  error_sign = "E",
  warn_sign = "W",
  hint_sign = "H",
  infor_sign = "I",
  diagnostic_header_icon = "   ",
  code_action_icon = " ",
  code_action_prompt = { enable = true, sign = true, sign_priority = 20, virtual_text = true },
  code_action_keys = { quit = "q", exec = "<CR>" },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-j>",
    scroll_up = "<C-k>",
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<CR>", -- quit can be a table
  },
  definition_preview_icon = "  ",
  --singele, double, round, plus
  border_style = "round",
  rename_prompt_prefix = "➤",
})
