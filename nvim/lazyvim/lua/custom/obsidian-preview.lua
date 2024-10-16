local M = {}

-- Variable to toggle Obsidian auto-open
M.auto_open_enabled = false

-- Function to determine if inside an Obsidian vault
local function is_obsidian_vault()
  local root_path = vim.fn.finddir(".obsidian", ";")
  return root_path ~= ""
end

-- Initialize auto-open based on vault presence
M.auto_open_enabled = is_obsidian_vault()

-- Function to open the current file in Obsidian Preview
function M.open_obsidian_preview()
  local file = vim.fn.expand("%:p")
  local obsidian_uri = "obsidian://open?path=" .. file .. "&preview=true"

  vim.fn.jobstart({ "xdg-open", obsidian_uri }, { detach = true })
end

-- Command to open the current buffer in Obsidian
vim.api.nvim_create_user_command("ObsidianPreview", M.open_obsidian_preview, {})

-- Auto command to view in Obsidian on Buffer Enter
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*.md",
  callback = function()
    if M.auto_open_enabled then
      M.open_obsidian_preview()
    end
  end,
})

-- Toggle function for enabling/disabling auto-open
function M.toggle_auto_open()
  -- make sure to update obsidian
  M.open_obsidian_preview()

  -- toggle
  M.auto_open_enabled = not M.auto_open_enabled
  local status = M.auto_open_enabled and "enabled" or "disabled"
  print("Obsidian auto-open " .. status)
end

-- Keybinding for toggling auto-open
vim.keymap.set(
  "n",
  "<leader>co",
  M.toggle_auto_open,
  { desc = "Toggle Obsidian Auto-Open", noremap = true, silent = true }
)

return M
