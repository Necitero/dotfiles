# Dotfiles

Private configuration files managed with [Gum](https://github.com/charmbracelet/gum)

## ⚙️ Prerequisites

- Gum
- zsh

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
