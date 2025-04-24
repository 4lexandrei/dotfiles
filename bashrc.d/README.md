# bashrc.d

## Bat theme

Run to update bat theme:

```bash
bat cache --build
```

For a full functional experience please install additional packages listed below.

For Archlinux:

```bash
pacman -S eza bat slurp grim tmux ripgrep
```

(optional packages):

```bash
pacman -S obsidian syncthing
```

## Aliases

| Aliases |   Description    |
| :-----: | :--------------: |
|   sb    | Source `.bashrc` |
|   gs    |    Git status    |
|   gdt   |   Git difftool   |

| Script aliases |   Description    |
| :------------: | :--------------: |
|       mg       |     My gits      |
|     sshot      |    Screenshot    |
|       pp       | Preview pictures |
|       ts       | Tmux-sessionizer |

## Scripts

### note()

Opens `~/Documents/Notes/` with `nvim` alongside with `obsidian` and `syncthing` for note-taking.

### my-gits()

Easily list, navigate and check the status of your remote git repositories cloned on your machine.

### screenshot()

Take screenshots with `grim` and `slurp`.
Flags `-c` or `cut` screenshots a selected region.

### preview_pictures()

Preview images with `fzf + kitty icat`.

### Tmux-sessionizer()

Quickly create or jump between tmux sessions.
