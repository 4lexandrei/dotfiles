local max_width = 50
local max_height = 10

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.filesystem = vim.tbl_deep_extend("force", opts.filesystem or {}, {
        filtered_items = {
          visible = true,
        },
        hijack_netrw_behavior = "open_default",
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      }
      opts.sections.lualine_b = {
        {
          "branch",
          icon = { "", align = "left" },
        },
      }
      opts.sections.lualine_y = {
        {
          "progress",
        },
      }
      opts.sections.lualine_z = {
        {
          "location",
        },
      }
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    -- enabled = false,
    event = "VimEnter",
    opts = function(_, opts)
      --       local logo = [[
      -- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
      -- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
      -- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
      -- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
      -- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
      -- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      --       ]]
      local logo = [[
 █████╗ ██╗     ███████╗██╗  ██╗ █████╗ ███╗   ██╗██████╗ ██████╗ ███████╗██╗
██╔══██╗██║     ██╔════╝╚██╗██╔╝██╔══██╗████╗  ██║██╔══██╗██╔══██╗██╔════╝██║
███████║██║     █████╗   ╚███╔╝ ███████║██╔██╗ ██║██║  ██║██████╔╝█████╗  ██║
██╔══██║██║     ██╔══╝   ██╔██╗ ██╔══██║██║╚██╗██║██║  ██║██╔══██╗██╔══╝  ██║
██║  ██║███████╗███████╗██╔╝ ██╗██║  ██║██║ ╚████║██████╔╝██║  ██║███████╗██║
╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝
    ]]

      logo = string.rep("\n", 5) .. logo .. "\n"

      opts.config.header = vim.split(logo, "\n")
    end,
  },
  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      opts.winopts.preview.scrollbar = false
      opts.winopts.backdrop = false
      opts.fzf_colors = {
        true,
        bg = "-1",
        gutter = "-1",
      }
    end,
  },
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        themable = true,
        separator_style = { "", "" },
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "StatusLine",
            text_align = "left",
            separator = true,
          },
        },
        show_buffer_close_icons = false,
        -- hover = {
        --   enabled = true,
        --   delay = 200,
        --   reveal = { "close" },
        -- }
      })
      opts.highlights = vim.g.bufferline_highlights or {}
    end,
  },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      if vim.g.signature ~= "noice" then
        opts.lsp.signature = {
          enabled = false,
        }
      end
      opts.lsp = vim.tbl_deep_extend("force", opts.lsp or {}, {
        -- Uncomment to disable lsp loading bar
        -- progress = {
        --   enabled = false,
        -- },

        documentation = {
          opts = {
            size = { max_width = max_width, max_height = max_height },
            border = "single",
            scrollbar = false,
          },
        },
      })

      -- Bottom cmdline
      opts.cmdline = {
        view = "cmdline",
      }
      opts.presets.command_palette = false
      opts.views = {
        cmdline = {
          position = {
            row = -1,
          },
        },
        cmdline_popupmenu = {
          position = {
            row = -2,
            col = 1,
          },
        },
      }
    end,
  },
}
