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
}
