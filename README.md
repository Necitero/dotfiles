# Dotfiles

Private configuration files managed with [Gum](https://github.com/charmbracelet/gum)

## 🔧 Installation

1. Make sure you have git installed
2. Install `gum`

**🍎 MacOS**
```bash
brew install gum
```
**🐧 Linux**
```bash
# Fedora
sudo dnf install gum
# Arch
sudo pacman -S gum
# Ubuntu
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install gum
```
3. Clone repository
```bash
cd ~/ && git clone git@github.com:Necitero/dotfiles.git
```

## 🚀 Usage

### Adding files

To add or modify configurations, simply add the file to this repository. Please be aware of the directory:

`~/.file` can just be moved to the root of this repository.

`~/.config/.file` should be moved to this repository under `./config`

**Example**

```
dotfiles/
├── .config/            # Configuration packages
│   ├── nvim/           # Neovim configuration
│   └── fastfetch/      # Fastfetch configuration
└── .zshrc              # zsh configuration file
```

### Symlink files

To actually symlink the files so your system can use them, simply do:

   ```bash
   bash init.sh # --dry-run optional
   ```

## ⚠️ REMINDER TO SELF

Please do NOT upload any .ssh keys, .env variables or anything else. While this is a private repository, let's just stay suspicious of attacks.
