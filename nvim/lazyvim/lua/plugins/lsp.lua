return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "shellcheck",
        "bash-language-server",
        "clangd",
        "clang-format",
        "typescript-language-server",
        "eslint-lsp",
        "json-lsp",
        "html-lsp",
      },
    },
  },
}
