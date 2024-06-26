require("onedarkpro").setup({
  options = {
    cursorline = true,                 -- Use cursorline highlighting?
    transparency = false,              -- Use a transparent background?
    terminal_colors = true,            -- Use the theme's colors for Neovim's :terminal?
    lualine_transparency = false,      -- Center bar transparency?
    highlight_inactive_windows = true, -- When the window is out of focus, change the normal background?
  }
})
vim.cmd.colorscheme "onedark"
