
# bashrc.d

## Aliases

| Aliases | Description |
|:-------:|:-----------:|
| ef | search files with fzf and edit with `$EDITOR` on `Enter` |
| cdf | search directories with fzf and change directory on `Enter` |
| bb | Bashbuddy |

## Functions

The `note()` function opens `~/Documents/Notes/` with `nvim` alongside with `obsidian` and syncthing.

---

The `screenshot()` function takes screenshots with `grim` and `slurp`

```bash
alias='sshot'
```

Flags `-c` or `cut` screenshots a selected region.

---

The `preview_pictures()` previews images with `fzf + kitty icat`

```bash
alias='pp'
```
