return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "qmlls",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "qmljs",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        qmlls = {
          cmd = {
            "qmlls",
            "-I",
            "/usr/lib/qt6/qml/",
          },
          -- on_attach = function(client, _)
          --   client.handlers["textDocument/publishDiagnostics"] = function() end
          -- end,
        },
      },
    },
  },
}
