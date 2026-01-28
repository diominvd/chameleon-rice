<div align="center">

# vibegen-dots

![Stars](https://img.shields.io/github/stars/diominvd/vibegen-dots?style=for-the-badge&color=cba6f7&logo=github)
![Forks](https://img.shields.io/github/forks/diominvd/vibegen-dots?style=for-the-badge&color=89b4fa&logo=github)
![OS](https://img.shields.io/badge/OS-Arch_Linux-icon?style=for-the-badge&logo=arch-linux&logoColor=1793D1&color=45475a)

Hyprland desktop environment with adaptive color palette based on wallpaper.

[Gallery](#gallery) • [Components](#components) • [Features](#features) • [Dependencies](#dependencies) • [Installation](#installation) • [Keybinds](#keybinds)

<img src="assets/preview.png" width="800" alt="Chameleon Rice Preview">

</div>

---

> [!WARNING]
> This is a personal configuration. Use at your own risk. **Always back up your current configurations before installation!**
> These dotfiles are specifically designed for **Arch Linux** with the **Hyprland** Wayland compositor.

## Gallery
...

## Components
...

## Features
...

## Dependencies

To ensure a successful installation, you need to install the following packages.

### Prerequisites

Ensure your system is up-to-date and you have `git` and `yay` (an AUR helper) installed. If `yay` is not installed, execute the following commands:

```bash
sudo pacman -Syu # Update your system
sudo pacman -S --needed git base-devel # Install git and essential build tools
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
```

### Core

```bash
sudo pacman -S wayland hyprland xdg-desktop-portal-hyprland qt5-wayland qt6-wayland stow
```

### UI & Appearance

```bash
sudo pacman -S waybar rofi mako swww matugen hyprlock kvantum kvantum-qt5
yay -S adw-gtk-theme ttf-jetbrains-mono-nerd
```

### Terminal & Shell

```bash
sudo pacman -S kitty zsh tmux starship fastfetch eza bat
yay -S oh-my-zsh-git
```

### Tools & Utils

```bash
sudo pacman -S neovim python python-pip ripgrep bc fzf gum thunar imv grim slurp wf-recorder wl-clipboard brightnessctl btop pacman-contrib
yay -S zed systemd-manager-tui wifitui bluetuith
```

### Media

```bash
sudo pacman -S mpd mpc mpd-mpris playerctl wireplumber
yay -S rmpc wiremix zen-browser-bin # Note: zen-browser-bin is an AUR package
```

## Installation

Follow these steps to install and set up the dotfiles.

### Quick Install

```bash
# 1. Back up your existing configurations (VERY IMPORTANT!)
# This will create a backup of your ~/.config directory.
cp -r ~/.config ~/.config.backup
# If you have an existing ~/.zshrc, back it up as well.
cp ~/.zshrc ~/.zshrc.backup || true

# 2. Clone the dotfiles repository to your home directory
git clone https://github.com/diominvd/vibegen-dots.git ~/.dotfiles
cd ~/.dotfiles

# 3. Install all required dependencies
# Please refer to the "Dependencies" section above and execute all listed pacman and yay commands.

# 4. Create necessary directories
# These directories are used for wallpapers, screen recordings, and music.
mkdir -p ~/Pictures/Wallpapers ~/Videos/Screenrecords ~/Music

# 5. Remove conflicting configurations
# This step is crucial to prevent conflicts when 'stow' creates symlinks.
rm -rf ~/.config/{hypr,waybar,rofi,kitty,mako,fastfetch,nvim,tmux,zed,mpd,yamusic} # Ensure this list is complete and matches your dotfiles structure
rm -f ~/.zshrc

# 6. Deploy configurations with stow
# Stow will create symbolic links from your ~/.dotfiles directory to your home directory.
stow -v -t ~ fastfetch gtk-3.0 gtk-4.0 hypr kitty matugen mpd nvim rofi scripts tmux wallpapers waybar yamusic zed zen-browser zsh

# 7. Set zsh as your default shell
chsh -s $(which zsh)

# 8. Reboot your system and select the Hyprland session in your login manager (e.g., SDDM, GDM)
reboot
```

### Post-Install

After successful installation, follow these additional steps:

**Add Wallpapers:**
Copy your preferred wallpapers to the `~/Pictures/Wallpapers/` directory.
```bash
cp /path/to/your/wallpapers/* ~/Pictures/Wallpapers/
# Use Super + Shift + W to apply a random wallpaper and generate the color scheme.
```

**Configure Music (MPD):**
Copy your music files to the `~/Music/` directory.
```bash
cp /path/to/your/music/* ~/Music/
mpc update # Update the MPD database
```

## Keybinds

| Keybind | Action |
|---------|--------|
| `Super + Return` | Terminal |
| `Alt + Space` | System menu |
| `Super + Q` | Close window |
| `Super + M` | Exit Hyprland |
| `Super + L` | Lock screen |

See `~/.config/hypr/config/keybinds.conf` for a full list.

## Troubleshooting

**Waybar not showing:**
```bash
killall waybar && waybar &
```

**Colors not applying:**
```bash
matugen image ~/Pictures/Wallpapers/your-wallpaper.jpg
hyprctl reload
```

**Check logs:**
```bash
journalctl -b | grep hyprland
```

## License

[MIT License](LICENSE)

---

<div align="center">

**If you like this config, give it a ⭐**

Made with ❤️ for the Hyprland community

</div>