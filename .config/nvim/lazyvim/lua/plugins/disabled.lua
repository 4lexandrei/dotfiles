return {
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
  },
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "nvim-mini/mini.ai",
    enabled = false,
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.bigfile = { enabled = false }
    end,
  },
}
