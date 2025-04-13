return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      ensure_installed = {
        -- Shell
        "shellcheck",
        "bash-language-server",
        -- C
        "clangd",
        "clang-format",
        -- JSON
        "json-lsp",
        -- Web-dev
        "html-lsp",
        "prettier",
        "typescript-language-server",
        "tailwindcss-language-server",
        "eslint-lsp",
        -- Rust
        "rust-analyzer",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        c = { "clang-format" },
        markdown = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
      },
    },
  },
}
