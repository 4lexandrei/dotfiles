local M = {}
local curl = require("plenary.curl")
local last_cursor_line = -1 -- Initialize to an invalid line number
local debounce_timeout = 500 -- Trottle timeout
local vault_path = "/home/alexandrei/Documents/Notes"
local active = false
local PORT = 9000
local sync_scroll = true

local function calculate_frontmatter_lines()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local count = 0
  if #lines > 1 and lines[1]:match("^---") then
    for i = 2, #lines do
      count = count + 1
      if lines[i]:match("^---") then
        break
      end
    end
  end
  return count
end

-- collect neovim data
function M.get_cursor_data()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  return {
    method = "updateCursor",
    params = {
      line = line,
      totalLines = Total_lines,
      frontmatterLines = FrontmatterLines + 3,
    },
  }
end

function M.get_buffer_data()
  local full_path = vim.fn.expand("%:p")
  local relative_path = full_path:gsub(vault_path .. "/", "")
  return {
    method = "updateBuffer",
    params = {
      buffer_path = relative_path,
    },
  }
end

-- request
function M.send_request(data)
  local payload = vim.json.encode(data)
  curl.request({
    url = "http://localhost:" .. PORT .. "/rpc",
    method = "POST",
    headers = {
      ["Content-Type"] = "application/json",
    },
    body = payload,
    on_error = function(res)
      print(res.message)
    end,
    callback = function(res)
      if res and res.status == 200 then
        return
      else
        print("Unexpected response status", res.status)
      end
    end,
  })
end

-- on action
function M.on_cursor_moved()
  if M.is_in_vault() and active and sync_scroll then
    local current_line = vim.fn.getpos(".")[2]

    if current_line ~= last_cursor_line then
      last_cursor_line = current_line

      vim.defer_fn(function()
        M.send_request(M.get_cursor_data())
      end, debounce_timeout)
    end
  end
end

function M.on_buf_enter()
  if M.is_in_vault() and active then
    FrontmatterLines = calculate_frontmatter_lines()
    Total_lines = vim.fn.line("$")
    M.send_request(M.get_buffer_data())
  end
end

-- script toggle and initialization
function M.is_in_vault()
  local full_path = vim.fn.expand("%:p")
  return full_path:find(vault_path, 1, true)
end

if M.is_in_vault() then
  active = true
end

function M.toggle()
  active = not active
  if active then
    print("ObsidianSync enabled")
    M.send_request(M.get_buffer_data())
  else
    print("ObsidianSync disabled")
  end
end

function M.toggle_sync_scroll()
  sync_scroll = not sync_scroll
  if sync_scroll then
    print("ObsidianSyncScroll enabled")
  else
    print("ObsidianSyncScroll disabled")
  end
end

-- autocmds
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  pattern = "*.md",
  callback = M.on_cursor_moved,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  pattern = "*.md",
  callback = M.on_buf_enter,
})

-- user commands
vim.api.nvim_create_user_command("ToggleObsidianSync", M.toggle, {})
vim.api.nvim_create_user_command("ToggleObsidianSyncScroll", M.toggle_sync_scroll, {})

-- keymaps
vim.keymap.set("n", "<leader>co", M.toggle, { desc = "ToggleObsidianSync", noremap = true, silent = true })

return M
