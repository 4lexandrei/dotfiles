local M = {}
local curl = require("plenary.curl")
local last_cursor_line = -1 -- Initialize to an invalid line number
local last_request_time = 0 -- Timestamp of the last request
local debounce_timeout = 300 -- Trottle timeout
local vault_path = "/home/alexandrei/Documents/Notes"
local active = false

-- collect neovim data
function M.get_cursor_data()
  local line = vim.fn.getpos(".")[2]
  return {
    method = "updateCursor",
    params = {
      line = line,
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
    url = "http://localhost:8000/rpc",
    method = "POST",
    headers = {
      ["Content-Type"] = "application/json",
    },
    body = payload,
    on_error = function(res)
      print(res.message)
    end,
    callback = function() end,
  })
end

-- on action
function M.on_cursor_moved()
  if M.is_in_vault() and active then
    local current_line = vim.fn.getpos(".")[2]
    local current_time = vim.loop.now()

    -- Only send a request if the line has changed
    if current_line ~= last_cursor_line and (current_time - last_request_time >= debounce_timeout) then
      last_cursor_line = current_line -- Update the last cursor line
      last_request_time = current_time --Update the last request time
      M.send_request(M.get_cursor_data())
    end
  end
end

function M.on_buf_enter()
  if M.is_in_vault() and active then
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

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  pattern = "*.md",
  callback = M.on_cursor_moved,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  callback = M.on_buf_enter,
})

vim.api.nvim_create_user_command("ToggleObsidianSync", M.toggle, {})

vim.keymap.set("n", "<leader>co", M.toggle, { desc = "ToggleObsidianSync", noremap = true, silent = true })

return M
