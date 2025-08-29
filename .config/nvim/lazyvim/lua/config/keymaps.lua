-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- `n` Normal mode
-- `x` Visual mode
-- `"_` will not be saved to clipboard (blackhole register)

vim.keymap.set("n", "dd", '"_dd', { noremap = true })
vim.keymap.set("n", "dw", '"_dw', { noremap = true })
vim.keymap.set("n", "diw", '"_diw', { noremap = true })
vim.keymap.set("x", "d", '"_d', { noremap = true })
vim.keymap.set("x", "p", '"_dP', { noremap = true })
