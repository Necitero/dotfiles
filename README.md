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
dotfiles/
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

## ⚠️ Security Notes

Please do NOT upload any .ssh keys, .env variables or anything else. While this is a private repository, let's just stay suspicious of attacks.
