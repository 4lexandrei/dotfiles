return {
  {
    -- dashboard-nvim
    "nvimdev/dashboard-nvim",
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

      logo = string.rep("\n", 6) .. logo .. "\n"

      opts.config.header = vim.split(logo, "\n")
    end,
  },

  {
    -- notify
    "rcarriga/nvim-notify",
    opts = {
      timeout = 10000,
    },
  },
}
