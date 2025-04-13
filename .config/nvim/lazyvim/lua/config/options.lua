-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.clipboard = "unnamedplus"

vim.opt.conceallevel = 0

-- Prevent lsp to change root directory when using <leader>space
vim.g.root_spec = { "cwd" }
