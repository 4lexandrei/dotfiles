return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_transparent_background = 2
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_float_style = "bright"
      vim.cmd.colorscheme("gruvbox-material")

      local custom_highlights = true

      if custom_highlights then
        vim.api.nvim_create_autocmd("ColorScheme", {
          group = vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {}),
          pattern = "gruvbox-material",
          callback = function()
            -- local config = vim.fn["gruvbox_material#get_configuration"]()
            -- local palette =
            --   vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)
            -- local set_hl = vim.fn["gruvbox_material#highlight"]

            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#5a524c", bg = "NONE" })
            vim.api.nvim_set_hl(0, "FloatTitle", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })

            -- blink.cmp
            if LazyVim.has("blink.cmp") then
              vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "FloatBorder" })
              -- vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "NormalFloat" })
              vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { link = "CursorLine" })
              -- vim.api.nvim_set_hl(0, "BlinkCmpDoc", { link = "NormalFloat" })
              vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "FloatBorder" })
              vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { link = "FloatBorder" })
              vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { link = "FloatBorder" })
            end

            -- lualine.nvim
            if LazyVim.has("lualine.nvim") then
              vim.api.nvim_set_hl(0, "StatusLine", { bg = "#32302F" })
              vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#32302F" })
              vim.api.nvim_set_hl(0, "StatusLineTerm", { bg = "#32302F" })
              vim.api.nvim_set_hl(0, "StatusLineTermNC", { bg = "#32302F" })
            end

            -- bufferline.nvim
            if LazyVim.has("bufferline.nvim") then
              local bufferline_highlight_groups = {
                default = {
                  "fill",
                  "background",
                  "separator",
                  "trunc_marker",
                  "offset_separator",
                },
                tab = {
                  "tab",
                  "tab_separator",
                  "tab_close",
                  "close_button",
                  "buffer_visible",
                  "numbers",
                  "diagnostic",
                  "hint",
                  "info",
                  "warning",
                  "error",
                  "modified",
                  "duplicate",
                  "pick",
                },
                visible = {
                  "close_button_visible",
                  "buffer_visible",
                  "numbers_visible",
                  "diagnostic_visible",
                  "hint_visible",
                  "info_visible",
                  "warning_visible",
                  "error_visible",
                  "modified_visible",
                  "duplicate_visible",
                  "separator_visible",
                  "indicator_visible",
                  "pick_visible",
                  "hint_diagnostic_visible",
                  "info_diagnostic_visible",
                  "warning_diagnostic_visible",
                  "error_diagnostic_visible",
                },
                selected = {
                  "tab_selected",
                  "tab_separator_selected",
                  "close_button_selected",
                  "buffer_selected",
                  "numbers_selected",
                  "diagnostic_selected",
                  "hint_selected",
                  "info_selected",
                  "warning_selected",
                  "error_selected",
                  "modified_selected",
                  "duplicate_selected",
                  "separator_selected",
                  "indicator_selected",
                  "pick_selected",
                  "hint_diagnostic_selected",
                  "info_diagnostic_selected",
                  "warning_diagnostic_selected",
                  "error_diagnostic_selected",
                },
                diagnostic = {
                  "hint_diagnostic",
                  "info_diagnostic",
                  "warning_diagnostic",
                  "error_diagnostic",
                },
              }

              local bufferline_styles = {
                default = { bg = "#32302f" },
                tab = { bg = "#32302f" },
                visible = { bg = "#32302f" },
                selected = { link = "Normal", italic = false },
                diagnostic = { bg = "#32302f" },
              }

              local bufferline_highlights = {}

              for category, hl_groups in pairs(bufferline_highlight_groups) do
                local style = bufferline_styles[category] or { bg = "#32302F" }
                for _, hl in ipairs(hl_groups) do
                  bufferline_highlights[hl] = { bg = style.bg, italic = style.italic }
                end
              end

              -- TODO: Find a better way to export bufferline_highlights
              if vim.g.bufferline_highlights == nil then
                vim.g.bufferline_highlights = bufferline_highlights
              end
            end
          end,
        })
      end
    end,
  },
}
