return {
  {
    "williamboman/mason.nvim",
    opts = {
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
