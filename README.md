# dotfiles

This repository contains my personal dotfiles.

![pacman-gruvbox](screenshots/gruvbox-dotfiles.png)

## My setup

**Desktop Environment:** [`Hyprland`](hypr/README.md)  
**Shell:** [`bash`](bashrc.d/README.md)  
**Terminal:** `kitty`  
**Terminal Multiplexer:** [`tmux`](tmux/README.md)  
**Text Editor:** `neovim`  
**Colorscheme:** `Gruvbox Material`

### neovim

#### nvim

Neovim default

#### lazyvim

Neovim distro + additional plugins  
**Theme:** Gruvbox Material  

## Installation

Clone repository
```bash
git clone https://github.com/4lexandrei/dotfiles.git ~/.dotfiles
```
Symlink dotfiles command
```bash
ln -snf ~/.dotfiles/bin/dotfiles ~/.local/bin/
```

## Usage

Run command 
```bash
dotfiles
```

> [!NOTE]
> Select:
> ```bash
> ./main.sh # Symlinks repository dotfiles to your system.
> ```
> ```bash
> ./nvim.sh # Sets up neovim.
> ```
