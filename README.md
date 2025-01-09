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

`nvim`  

Neovim default configuration  

`lazyvim`  

Neovim distro + additional plugins  

## Installation

Clone repository:
```bash
git clone https://github.com/4lexandrei/dotfiles.git ~/.dotfiles
```

For the latest (unstable) version, clone the `dev` branch:
```bash
git clone -b dev https://github.com/4lexandrei/dotfiles.git ~/.dotfiles
```

## Usage

run dotfiles setup command
```bash
~/.dotfiles/bin/dotfiles
```

---

## Windows Support

For Windows users, open Powershell as Administrator and run the following snippet to create symlinks
```powershell
New-Item -ItemType SymbolicLink -Path "link" -Target "path_to_link"
```

Examples:
SymbolicLink for lazyvim
```powershell
New-Item -ItemType SymbolicLink -Path "C:\Users\alexa\AppData\Local\nvim" -Target "C:\Users\alexa\.dotfiles\.config\nvim\lazyvim"
```
SymbolicLink for .bashrc
```powershell
New-Item -ItemType SymbolicLink -Path "C:\Users\alexa\.bashrc" -Target "C:\Users\alexa\.dotfiles\.bashrc"
```
