-- return {
--   -- Add gruvbox
--   {
--     "ellisonleao/gruvbox.nvim",
--     enabled = true,
--     lazy = true,
--     priority = 1000,
--     opts = function()
--       vim.o.background = "dark"
--       return {
--         transparent_mode = true,
--       }
--     end,
--   },
--
--   -- Configure LazyVim to load gruvbox
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "gruvbox",
--     },
--   },
-- }

return {
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_transparent_background = 1
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
}
