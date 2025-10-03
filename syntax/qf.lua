if vim.b.current_syntax == 'qf' then
  return
end

-- For the syntax matching, we still use vimscript via vim.cmd as there is no
-- direct Lua equivalent for `syn match` with `nextgroup` that is as concise.
vim.cmd([[
  syn match qfFileName /^[^│]*/ nextgroup=qfSeparatorLeft
  syn match qfSeparatorLeft /│/ contained nextgroup=qfLineNr
  syn match qfLineNr /[^│]*/ contained nextgroup=qfSeparatorRight
  syn match qfSeparatorRight '│' contained nextgroup=qfError,qfWarning,qfInfo,qfNote
  syn match qfError / E .*$/ contained
  syn match qfWarning / W .*$/ contained
  syn match qfInfo / I .*$/ contained
  syn match qfNote / [NH] .*$/ contained
]])

-- Use the modern Lua API to link the highlight groups.
-- The `default = true` parameter is equivalent to `hi def link`.
vim.api.nvim_set_hl(0, 'qfFileName', { link = 'Directory', default = true })
vim.api.nvim_set_hl(0, 'qfSeparatorLeft', { link = 'Delimiter', default = true })
vim.api.nvim_set_hl(0, 'qfSeparatorRight', { link = 'Delimiter', default = true })
vim.api.nvim_set_hl(0, 'qfLineNr', { link = 'LineNr', default = true })
vim.api.nvim_set_hl(0, 'qfError', { link = 'DiagnosticError', default = true })
vim.api.nvim_set_hl(0, 'qfWarning', { link = 'DiagnosticWarn', default = true })
vim.api.nvim_set_hl(0, 'qfInfo', { link = 'DiagnosticInfo', default = true })
vim.api.nvim_set_hl(0, 'qfNote', { link = 'DiagnosticHint', default = true })

vim.b.current_syntax = 'qf'
