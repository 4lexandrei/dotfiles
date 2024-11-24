return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        enabled = false,
        width = 50,
        preset = {
          header = [[



███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ 
▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
  ░   ░  ░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒  ░  ░      ░
          ]],
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 2 },
          { section = "startup" },
        },
      },
    },
  },

  {
    "nvimdev/dashboard-nvim",
    enabled = true,
    lazy = false,
    opts = function(_, opts)
      local logo = [[
███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ 
▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
  ░   ░  ░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒  ░  ░      ░
      ]]

      logo = string.rep("\n", 5) .. logo .. "\n"

      opts.config.header = vim.split(logo, "\n")
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 10000,
    },
  },
}
