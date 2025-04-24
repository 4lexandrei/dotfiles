local max_width = 50
local max_height = 10

return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.appearance = vim.tbl_deep_extend("force", opts.appearance or {}, {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
        kind_icons = {
          Text = "󰉿 ",
          Snippet = " ",
        },
      })

      opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
        -- single = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
        menu = {
          scrollbar = false,
          border = "single",
          winblend = 0,
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },
        documentation = {
          auto_show = true,
          window = {
            scrollbar = false,
            border = "single",
            winblend = 0,
            max_width = max_width,
            max_height = max_height,
          },
        },
      })

      -- NOTE: Still experimental
      if vim.g.signature == "blink" then
        opts.signature = {
          enabled = true,
          window = {
            border = "single",
            show_documentation = true,
            max_width = max_width,
            max_height = max_height,
          },
        }
      end

      opts.keymap = vim.tbl_deep_extend("force", opts.keymap or {}, {
        preset = "super-tab", -- presets: "default" | "enter" | "super-tab""
        -- ["<TAB>"] = { "select_and_accept" },
      })
    end,
  },
}
