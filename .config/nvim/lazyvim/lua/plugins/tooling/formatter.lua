return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        markdown = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
      },
      formatters = {
        injected = { options = { ignore_errors = false } },
      },
    },
  },
}
