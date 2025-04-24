return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        backdrop = 100,
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      ensure_installed = {
        -- Lua
        "stylua",
        -- Shell
        "shellcheck",
        "shfmt",
        "bash-language-server",
        -- JSON
        "json-lsp",
        -- Web-dev
        "html-lsp",
        "typescript-language-server",
        "tailwindcss-language-server",
        "eslint-lsp",
        "prettier",
      },
    },
  },
}
