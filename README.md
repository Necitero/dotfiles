# 📁 Dotfiles

Personal configuration files with interactive import selection for Linux and macOS.

## ⚙️ Prerequisites

- [Gum](https://github.com/charmbracelet/gum) - Interactive selection UI (init.sh)
- zsh - Main shell

## 🚀 Usage

### ➕ Adding Files

To add or modify configurations, simply add the file to this repository. Please note the directory layout:

`~/<file>` should be placed in the `/source/` directory of this repository.

`~/.config/<file>` should be placed in the `/source/.config/` directory of this repository.

**Example**

```
source/
├── .config/            # Configuration packages
│   ├── nvim/           # Neovim configuration
│   └── fastfetch/      # Fastfetch configuration
└── .zshrc              # zsh configuration file
```

### 🔗 Symlink Files

To actually symlink the files so your system can use them, simply run:

```bash
bash init.sh # --dry-run optional
```

## 🔧 Config Specifics

### 👻 Ghostty (macOS)

Ghostty's default config path is located in macOS's `$HOME/Library/` directory. To ensure there is a proper symlink, in addition to the script, run this command:

```bash
ln -s ~/.config/ghostty/config $HOME/Library/Application\ Support/com.mitchellh.ghostty/config
```

## 📝 Notes

### 📄 License

This repository is released under the MIT license.  
Feel free to copy, modify, or use anything for your own setup.

### 🌐 Cloning / Forking / Contributions

Feel free to copy anything! My config is under constant maintenance, trying to optimize my workflow, setup, styles, etc. If you feel like you need something from here, just take it! No matter if it's a specific configuration I have, the whole init.sh, anything.

When it comes to contributions (PRs, issues, etc.): I will most likely not respond to them. This is mainly my personal repository, just made public so people can use it for inspiration or clones/forks.

### ⚠️ Security Notes

Please do NOT upload any SSH keys, environment variables or any other sensitive information. This is a reminder to myself, but also to anyone who wants to clone this repo.
