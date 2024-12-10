return {
  {
    "neobsync.nvim",
    dir = "/home/alexandrei/dev/neovim/neobsync.nvim",
    config = function()
      require("neobsync.config").setup({
        vault_path = "/home/alexandrei/Documents/Notes/",
        HOST = "127.0.0.1",
        PORT = 9000,
      })
      require("neobsync").setup()
    end,
  },
}
