return {
  -- Add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    enabled = true,
    lazy = true,
    priority = 1000,
    opts = function()
      vim.o.background = "dark"
      return {
        transparent_mode = true,
      }
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
