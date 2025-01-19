return {
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
}
