local is_windows = vim.uv.os_uname().version:match("Windows")
local base_dir = is_windows and "C:\\Users\\alexa\\dev\\neovim\\" or "/home/alexandrei/dev/neovim/"
local vault_path = is_windows and "C:\\Users\\alexa\\Documents\\Notes\\" or "/home/alexandrei/Documents/Notes/"
local dir_exists = vim.uv.fs_stat(base_dir) ~= nil

return {
  {
    "neobsync.nvim",
    enabled = dir_exists,
    dir = base_dir .. "neobsync.nvim",
    config = function()
      require("neobsync.config").setup({
        vault_path = vault_path,
        HOST = "127.0.0.1",
        PORT = 9000,
      })
      require("neobsync").setup()
    end,
  },
}
