# dotfiles

## How to use
Clone repository
```bash
git clone https://github.com/4lexandrei/dotfiles.git ~/.dotfiles
```
Symlink dotfiles command
```bash
ln -snf ~/.dotfiles/bin/dotfiles ~/.local/bin/
```
Run command 
```bash
dotfiles
```

> **INFO:**  
```bash
./main.sh # Symlinks repository dotfiles to your system.
```
```bash
./nvim.sh # Sets up neovim.
```


## My setup

**Desktop Environment:** [`Hyprland`](#hyprland) / [`KDE Plasma`](#kde-plasma)  
**Shell:** [`bash`](#bash)  
**Terminal:** [`kitty`](#kitty) / [`konsole`](#konsole)  
**Terminal Multiplexer:** [`tmux`](#tmux)  
**Text Editor:** [`neovim`](#neovim)

### Desktop Environment
#### Hyprland
**Terminal:** `kitty`  
**File Manager:** `dolphin`  
**Menu:** `rofi-wayland`
| Actions | Keybinds |
|:-------:|:--------:|
| Fullscreen | `mainMod` + `F` |
| Togglesplit | `mainMod` + `T` |
| Move focus | `mainMod` + `vim mode` |
| Swapwindow | `mainMod` + `arrow keys` |

#### KDE Plasma

### Shell
#### bash
Custom aliases  
| Aliases | Description |
|:-------:|:-----------:|
| ef | search files with fzf and edit with `$EDITOR` on `Enter` |
| cdf | search directories with fzf and change directory on `Enter` |
| bb | Bashbuddy |

### Terminal
#### kitty
**Theme:** Gruvbox Material Dark
- Transparent background
#### konsole
- Transparent background

### Terminal Multiplexer
#### tmux
Keybinds
| Actions | Keybinds |
|:-------:|:--------:|
| Split panes | `C-b` + `\|` or `-` |
| Select panes | `C-b` + `vim mode` |

### Text Editor
#### neovim
##### nvim
Neovim default
##### lazyvim
Neovim distro + additional plugins  
**Theme:** Gruvbox  
**Plugins:**
- Markdown Preview
- Custom Dashboard

Disabled conceallevel for `.md` filetype

