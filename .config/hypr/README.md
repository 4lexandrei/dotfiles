
# Hypr

> [!NOTE]
> Current configuration limits number of workspaces to 5. For additional workspaces please edit `.config/hypr/hyprland.conf`.

Please install below packages to make hyprland configuration fully functional.

For Archlinux:
```bash
sudo pacman -S kitty hyprpaper waybar rofi-wayland
```

## Programs

**Terminal** -> `kitty`  
**Menu** -> `rofi`  

## Autostarts
- `hyprpaper`
- `waybar`

## Custom keybinds

| Actions              | Keybinds                       |
|:--------------------:|:------------------------------:|
| Fullscreen           | `mainMod` + `F`                |
| Togglesplit          | `mainMod` + `T`                |
| Move focus           | `mainMod` + `vim mode(hjkl)`   |
| Swapwindow           | `mainMod` + `arrow keys`       |
| Reload hyprpaper     | `mainMod` + `W`                |
| Reload waybar        | `mainMod SHIFT` + `W`          |
| Resize active window | `mainMod SHIFT` + `arror keys` |
| Move active window   | `mainMod SHIFT` + `vim mode`   |
| Center active window | `mainMod SHIFT` + `C`          |

