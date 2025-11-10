#!/usr/bin/env bash
set -euo pipefail

# Simple selective symlink creator for a dotfiles repo.
# - Only shows repo-root items (excluding .config) and first-level items under .config/
# - Creates symlinks into $HOME and $HOME/.config respectively
# - Backs up existing targets safely
# - Supports gum/fzf selection when available; otherwise uses a numbered fallback
#
# Usage:
#   bash link-dotfiles.sh               # interactive
#   bash link-dotfiles.sh --dry-run     # show what would happen
#   bash link-dotfiles.sh --target /some/home  # link into a different home base

# ------------- Config / args -------------
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

# Absolute path to the repo root (directory of this script)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ------------- Helpers -------------
timestamp() { date +"%Y%m%d-%H%M%S"; }

backup_existing() {
  local dest="$1"
  [[ -e "$dest" || -L "$dest" ]] || return 0
  # If already the correct symlink, skip backup
  return 0
}

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

  # If dest is already a symlink to src, skip
  if [[ -L "$dest" ]]; then
    local current
    current="$(readlink "$dest")" || true
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

have_cmd() { command -v "$1" >/dev/null 2>&1; }

# ------------- Build choice list -------------
# Root-level items (exclude .git and .config)
mapfile -t ROOT_ITEMS < <(
  find "$REPO_DIR" -maxdepth 1 -mindepth 1 \
    ! -name ".git" ! -name ".config" ! -name "init.sh" ! -name "README.md" \
    -exec basename {} \; | sort
)

# First-level under .config (if present)
CONFIG_DIR="$REPO_DIR/.config"
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
  echo "No selectable items found." >&2
  exit 1
fi

# ------------- Selection UI -------------
select_with_gum() {
  gum choose --no-limit "${CHOICES[@]}"
}

select_with_fzf() {
  printf '%s\n' "${CHOICES[@]}" | fzf -m
}

select_with_fallback() {
  echo "Select one or more items by number (space/comma separated), then press Enter:"
  local i=1
  for c in "${CHOICES[@]}"; do
    printf " %2d) %s\n" "$i" "$c"
    ((i++))
  done
  printf "Your choice(s): "
  local input
  IFS= read -r input
  # Accept e.g. "1 3 5" or "1,3,5"
  input="${input//,/ }"
  local idx
  local out=()
  for idx in $input; do
    if [[ "$idx" =~ ^[0-9]+$ ]] && (( idx>=1 && idx<=${#CHOICES[@]} )); then
      out+=("${CHOICES[idx-1]}")
    fi
  done
  printf '%s\n' "${out[@]}"
}

echo "Select files and directories to link:"
SELECTED=""
if have_cmd gum; then
  SELECTED="$(select_with_gum || true)"
elif have_cmd fzf; then
  SELECTED="$(select_with_fzf || true)"
else
  SELECTED="$(select_with_fallback || true)"
fi

if [[ -z "$SELECTED" ]]; then
  echo "No selection made. Exiting."
  exit 0
fi

# ------------- Link loop -------------
echo
echo "Planned links (target home: $TARGET_HOME):"
while IFS= read -r item; do
  # item starts with "/"
  if [[ "$item" == "/.config/"* ]]; then
    name="${item#/.config/}"                 # e.g., "nvim"
    src="$REPO_DIR/.config/$name"            # repo source
    dest="$TARGET_HOME/.config/$name"        # home destination
  else
    name="${item#/}"                          # e.g., ".zshrc"
    src="$REPO_DIR/$name"
    dest="$TARGET_HOME/$name"
  fi

  if [[ ! -e "$src" && ! -L "$src" ]]; then
    echo "⚠︎ Skipping missing source: $src" >&2
    continue
  fi

  link_one "$src" "$dest"
done <<< "$SELECTED"

echo
$DRY_RUN && echo "Dry run complete." || echo "All done."

