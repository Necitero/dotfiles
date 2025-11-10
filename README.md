# Dotfiles

Private configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## 🔧 Installation

1. Make sure you have git installed
2. Install GNU Stow

    **🍎 MacOS**
    ```bash
    brew install stow
    ```

    **🐧 Linux**
    ```bash
    # Fedora
    sudo dnf install stow
    # Arch
    sudo pacman -S stow
    # Ubuntu
    sudo apt install stow
    ```
3. Clone repository

    ```bash
    cd ~/ && git clone git@github.com:Necitero/dotfiles.git
    ```

4. Use the magic of stow
    
    ```bash
    stow .
    ```

## 🚀 Usage

### Adding files to Stow

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

### Symlink files with Stow

To actually symlink the files so your system can use them, simply do:

    ```bash
    stow .
    ```

## ⚠️ REMINDER TO SELF

Please do NOT upload any .ssh keys, .env variables or anything else. While this is a private repository, let's just stay suspicious of attacks.
