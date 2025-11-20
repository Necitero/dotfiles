# 📁 Dotfiles

Private configuration files with interactive import selection.

## ⚙️ Prerequisites

- [Gum](https://github.com/charmbracelet/gum) - Interactive selection UI (init.sh)
- zsh - Main shell

## 🚀 Usage

### ➕ Adding Files

To add or modify configurations, simply add the file to this repository. Please be aware of the directory:

`~/.file` can just be moved to `/source/` of this repository.

`~/.config/.file` should be moved to this repository under `/source/.config/`

**Example**

```
source/
├── .config/            # Configuration packages
│   ├── nvim/           # Neovim configuration
│   └── fastfetch/      # Fastfetch configuration
└── .zshrc              # zsh configuration file
```

### 🔗 Symlink Files

To actually symlink the files so your system can use them, simply do:

```bash
bash init.sh # --dry-run optional
```

## 🔧 Config Specifics

### 👻 Ghostty (MacOS)

Ghostty's default config path is in MacOS's `$HOME/Library/` directory. To ensure there is a proper symlink, additionally to the script, execute this command:

```bash
ln -s ~/.config/ghostty/config $HOME/Library/Application\ Support/com.mitchellh.ghostty/config
```

## 📝 Notes

## 🌐 Cloning / Forking / Contributions

Feel free to just fully rip off anything! My config is under constant maintenance, trying to optimize my workflow, setup, styles, etc. If you feel like you need something from here, just take it! No matter if it's a specific configuration I have, the whole init.sh, anything.

## ⚠️ Security Notes

Please do NOT upload any .ssh keys, .env variables or anything else. While this is a private repository, let's just stay suspicious of attacks.
