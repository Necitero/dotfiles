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

1. Open the terminal (SUPER+T)

2. Clone this repository

```
sudo dnf install git gum zsh
git clone https://github.com/Necitero/dotfiles
```

3. Copy the minimum required configs (zsh, hypr, rofi)

4. Install rofi, rofi-emoji and rofi-calc

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

5. WIP
