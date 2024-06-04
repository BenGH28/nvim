--bootstrap plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)


local opts = {
  change_detection = {
    notify = false,
  },
  install = {
    missing = true,
  },
  defaults = {
    lazy = true,
  },
}
-- loading my plugins
require("lazy").setup("plugins", opts)
