#!/usr/bin/env bash
set -euo pipefail

# Selective symlink creator for a dotfiles repo structured like:
# /
# |- init.sh
# |- README.md
# |- source/
#    |- .zshrc
#    |- .zsh.private
#    |- .zsh.work
#    |- .config/
#       |- nvim/
#       |- fastfetch/
#
# Shows only: /.<root items from source/> and /.config/<first-level items from source/.config/>
# Links to:   $HOME and $HOME/.config
#
# Usage:
#   bash init.sh               # interactive
#   bash init.sh --dry-run
#   bash init.sh --target /tmp/fakehome

DRY_RUN=false
TARGET_HOME="${HOME}"

while [[ "${1-}" =~ ^- ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true ;;
    --target) shift; TARGET_HOME="${1:?--target requires a path}";;
    *) echo "Unknown option: $1" >&2; exit 1;;
  esac
  shift || true
done

have_cmd() { command -v "$1" >/dev/null 2>&1; }

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$REPO_DIR/source"
CONFIG_DIR="$SOURCE_DIR/.config"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Error: expected directory '$SOURCE_DIR' but it does not exist." >&2
  exit 1
fi

timestamp() { date +"%Y%m%d-%H%M%S"; }

ensure_parent() {
  local path="$1"
  local dir
  dir="$(dirname "$path")"
  [[ -d "$dir" ]] || {
    $DRY_RUN && echo "[dry-run] mkdir -p '$dir'" || mkdir -p "$dir"
  }
}

link_one() {
  local src="$1"
  local dest="$2"

  # Already the correct symlink?
  if [[ -L "$dest" ]]; then
    local current; current="$(readlink "$dest")" || true
    if [[ "$current" == "$src" ]]; then
      echo "✓ Already linked: $dest -> $src"
      return 0
    fi
  fi

  # Backup existing file/dir/symlink if present
  if [[ -e "$dest" || -L "$dest" ]]; then
    local bak="${dest}.bak.$(timestamp)"
    $DRY_RUN && echo "[dry-run] mv '$dest' '$bak'" || mv "$dest" "$bak"
    echo "↷ Backed up: $dest -> $bak"
  fi

  ensure_parent "$dest"
  if $DRY_RUN; then
    echo "[dry-run] ln -s '$src' '$dest'"
  else
    ln -s "$src" "$dest"
    echo "→ Linked: $dest -> $src"
  fi
}

# Build choice list:
# - Root-level items in source/ (exclude .config and .gitignore etc. if you want)
mapfile -t ROOT_ITEMS < <(
  find "$SOURCE_DIR" -maxdepth 1 -mindepth 1 \
    ! -name ".config" \
    -exec basename {} \; | sort
)

# - First-level items inside source/.config (if present)
CONFIG_ITEMS=()
if [[ -d "$CONFIG_DIR" ]]; then
  mapfile -t CONFIG_ITEMS < <(
    find "$CONFIG_DIR" -maxdepth 1 -mindepth 1 \
      -exec basename {} \; | sort
  )
fi

CHOICES=()
for x in "${ROOT_ITEMS[@]}"; do
  CHOICES+=("/$x")
done
for x in "${CONFIG_ITEMS[@]}"; do
  CHOICES+=("/.config/$x")
done

if [[ ${#CHOICES[@]} -eq 0 ]]; then
  echo "No selectable items found in $SOURCE_DIR." >&2
  exit 1
fi

# Selection UI
select_with_gum() { gum choose --no-limit "${CHOICES[@]}"; }
select_with_fzf() { printf '%s\n' "${CHOICES[@]}" | fzf -m; }
select_with_fallback() {
  echo "Select one or more items by number (space/comma separated), then press Enter:"
  local i=1
  for c in "${CHOICES[@]}"; do
    printf " %2d) %s\n" "$i" "$c"
    ((i++))
  done
  printf "Your choice(s): "
  local input; IFS= read -r input
  input="${input//,/ }"
  local out=()
  for idx in $input; do
    if [[ "$idx" =~ ^[0-9]+$ ]] && (( idx>=1 && idx<=${#CHOICES[@]} )); then
      out+=("${CHOICES[idx-1]}")
    fi
  done
  printf '%s\n' "${out[@]}"
}

echo "Select files and directories to link:"
if have_cmd gum; then
  SELECTED="$(select_with_gum || true)"
elif have_cmd fzf; then
  SELECTED="$(select_with_fzf || true)"
else
  SELECTED="$(select_with_fallback || true)"
fi

if [[ -z "${SELECTED:-}" ]]; then
  echo "No selection made. Exiting."
  exit 0
fi

echo
echo "Planned links (target home: $TARGET_HOME):"
while IFS= read -r item; do
  [[ -z "$item" ]] && continue

  if [[ "$item" == "/.config/"* ]]; then
    name="${item#/.config/}"                         # e.g., "nvim"
    src="$SOURCE_DIR/.config/$name"                  # e.g., repo/source/.config/nvim
    dest="$TARGET_HOME/.config/$name"                # e.g., ~/.config/nvim
  else
    name="${item#/}"                                 # e.g., ".zshrc"
    src="$SOURCE_DIR/$name"                          # e.g., repo/source/.zshrc
    dest="$TARGET_HOME/$name"                        # e.g., ~/.zshrc
  fi

  if [[ ! -e "$src" && ! -L "$src" ]]; then
    echo "⚠︎ Skipping missing source: $src" >&2
    continue
  fi

  link_one "$src" "$dest"
done <<< "$SELECTED"

echo
$DRY_RUN && echo "Dry run complete." || echo "All done."

