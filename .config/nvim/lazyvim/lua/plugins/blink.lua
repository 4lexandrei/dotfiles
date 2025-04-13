local max_width = 50
local max_height = 10

return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
        documentation = {
          auto_show = true,
          window = {
            max_width = max_width,
            max_height = max_height,
          },
        },
      })

      opts.keymap = vim.tbl_deep_extend("force", opts.keymap or {}, {
        -- presets: default, enter, super-tab
        preset = "super-tab",
        -- ["<TAB>"] = { "select_and_accept" },
      })
    end,
  },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.lsp = vim.tbl_deep_extend("force", opts.lsp or {}, {
        -- LSP documentation popup
        signature = {
          -- False to disable documentation popup
          enabled = true,
          auto_open = {
            enabled = true,
          },
          opts = {
            -- Set max size for documentation popup
            size = { max_width = max_width, max_height = max_height },
          },
        },
      })
    end,
  },
}
