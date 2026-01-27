local util = require("lspconfig.util")

-- Detect ESP-IDF project
local function find_esp_root()
  -- 1) Standard ESP-IDF app root (sdkconfig)
  local app_root = util.root_pattern("sdkconfig")(vim.fn.getcwd())
  if app_root then
    return app_root
  end

  -- 2) ESP-IDF component / library root
  local cmake_root = util.search_ancestors(vim.fn.getcwd(), function(path)
    local cmake = path .. "/CMakeLists.txt"
    if vim.fn.filereadable(cmake) == 1 then
      local content = vim.fn.readfile(cmake)
      for _, line in ipairs(content) do
        if line:match("idf_component_register") then
          return true
        end
      end
    end
    return false
  end)

  return cmake_root
end
local esp_root = find_esp_root()
if not esp_root then
  return {}
end
-- vim.notify("ESP-IDF project detected")
-- vim.notify(esp_root)

local homedir = vim.uv.os_homedir()
local clangd_path = vim.fn.glob(homedir .. "/.espressif/tools/esp-clang/*/esp-clang/bin/clangd", true, true)[1]
local drivers = vim.fn.glob(homedir .. "/.espressif/tools/*-esp-elf/**/*-esp-elf/bin/*elf-gcc", true, true)

local query_args = {}
for _, d in ipairs(drivers) do
  table.insert(query_args, "--query-driver=" .. d)
end

return {
  vim.lsp.config("clangd", {
    cmd = vim.list_extend({
      clangd_path,
      "--background-index",
      "--clang-tidy",
      "--header-insertion=never",
      "--completion-style=detailed",
      "--fallback-style=llvm",
    }, query_args),
    root_markers = { "sdkconfig", "CMakeLists.txt" },
    filetypes = { "c", "cpp" },
  }),

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client or client.name ~= "clangd" then
        return
      end
      vim.keymap.set("n", "<leader>ch", "<cmd>LspClangdSwitchSourceHeader<cr>", {
        buffer = args.buf,
        desc = "Switch Source/Header (C/C++)",
      })
    end,
  }),
}
