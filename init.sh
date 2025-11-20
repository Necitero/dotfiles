#!/usr/bin/env bash

# NOTICE
# As I am not great at shell scripting, this file includes a lot of ai-generated lines.
# The rest of this repository is written by me or copied from documentations.
# Please just ... close your eyes here, thanks! <3

set -euo pipefail

DRY_RUN=false
TARGET_HOME="${HOME}"

while [[ "${1-}" =~ ^- ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true ;;
    *) echo "Unknown option: $1" >&2; exit 1;;
  esac
  shift
done

have_cmd() { command -v "$1" >/dev/null 2>&1; }

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$REPO_DIR/source"
CONFIG_DIR="$SOURCE_DIR/.config"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Error: expected directory '$SOURCE_DIR' but it does not exist." >&2
  exit 1
fi

# Create timestamp for backups
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
list_entries() {
  local dir="$1"
  local skip_config="${2:-false}"

  for p in "$dir"/.* "$dir"/*; do
    [ -e "$p" ] || continue
    base=${p##*/}
    [ "$base" = "." ] || [ "$base" = ".." ] && continue
    if $skip_config && [ "$base" = ".config" ]; then
      continue
    fi
    printf '%s\n' "$base"
  done | LC_ALL=C sort
}
ROOT_ITEMS=()
while IFS= read -r x; do ROOT_ITEMS+=("$x"); done < <(
  list_entries "$SOURCE_DIR" true
)

CONFIG_ITEMS=()
if [ -d "$CONFIG_DIR" ]; then
  while IFS= read -r x; do CONFIG_ITEMS+=("$x"); done < <(
    list_entries "$CONFIG_DIR"
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
    name="${item#/.config/}"
    src="$SOURCE_DIR/.config/$name"
    dest="$TARGET_HOME/.config/$name"
  else
    name="${item#/}"
    src="$SOURCE_DIR/$name"
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

