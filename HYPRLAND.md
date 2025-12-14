# Fedora Hyprland

## Installation

1. Install [Fedora Everything](https://www.fedoraproject.org/misc#everything)

2. Choose "Fedora Sway" and nothing additional

3. Reboot after install and use JaKooLit's [Fedora-Hyprland](https://github.com/JaKooLit/Fedora-Hyprland) installer:

```
sh <(curl -L https://raw.githubusercontent.com/JaKooLit/Fedora-Hyprland/main/auto-install.sh)
```

4. Choose needed packages (Thunar, Kitty, etc.)

## Post Installation

### Basics

1. Open the terminal (SUPER+T)

2. Update your system

```
sudo dnf update --refresh
```

3. Clone this repository

```
sudo dnf install git gum zsh
git clone https://github.com/Necitero/dotfiles
```

4. Copy the minimum required configs (zsh, hypr, rofi, wallpapers)

5. Install rofi, rofi-emoji and rofi-calc

Rofi will work as our main application launcher.

```
sudo dnf install rofi rofi-devel meson autoconf automake libtool
```

```
cd ~/Downloads
git clone https://github.com/svenstaro/rofi-calc.git
cd rofi-calc/
meson setup build
meson compile -C build/
cd build/
meson install
```

```
cd ~/Downloads
git clone https://github.com/Mange/rofi-emoji
autoreconf -i
mkdir build
cd build/
../configure
make
sudo make install
```

Rofi can now be opened using SUPER+R

6. ZSH

As most of my setup is done with ZSH in mind, I recommend setting ZSH as the default shell.

```
chsh -s $(which zsh)
```

At this point, it is recommended to reboot

### Neovim

1. Install Neovim

```
sudo dnf install nvim
```

2. Get configs

```
cd ~/dotfiles
bash init.sh
```

3. Open nvim and let vim-plug install all plugins
