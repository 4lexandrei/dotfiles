return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = {
        "lua",
        "bash",
        "markdown",
        "markdown_inline",
        "html",
        "javascript",
        "json",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "python",
        "cmake",
      }
    end,
  },
}
