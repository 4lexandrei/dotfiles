# NOTE!

## Linting

`.qmllint.ini`

Neovim's `qmlls` integration is currently unstable.
Known issues:

- Crashes on save, which may disable the LSP entirely.

If `qmllint` is not available, add it to your `$PATH` or create an alias for it:

```
alias qmllint="/usr/lib/qt6/bin/qmllint"
```

To use qmllint we first need `.qmllint.ini`, we can generate it using:

```
qmllint --write-defaults
```

Then add this line to it for additional qml import paths:

```
AdditionalQmlImportPaths=/home/<username>/builds/quickshell/build/qml_modules/
```

Manually diagnose qml files on terminal:

```
qmllint <file_path>
```

## Formatting

To configure `conform.nvim` to use `qmlformat`, please paste this configuration:

```lua
{
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
      qml = { "qmlformat" },
    })
    opts.formatters = vim.tbl_deep_extend("force", opts.formatters or {}, {
      qmlformat = {
        command = "/usr/lib/qt6/bin/qmlformat",
      },
    })
  end,
},
```
