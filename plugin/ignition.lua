vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "view.json", "props.json", "tags.json", "tag-groups.json", "udts.json" },
  callback = function()
    require("core.ignition").setup()
  end
})
