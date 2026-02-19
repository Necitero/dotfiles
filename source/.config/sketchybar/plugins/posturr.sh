#!/usr/bin/env bash
set -euo pipefail

ICON="󱉉"
STATE_FILE="/tmp/sketchybar-posturr-primed"
COOLDOWN_SECONDS=300  # only "prime" at most once every 5 minutes

now_epoch() { date +%s; }

should_prime() {
  if [[ ! -f "$STATE_FILE" ]]; then
    return 0
  fi
  local last
  last="$(cat "$STATE_FILE" 2>/dev/null || echo 0)"
  [[ "$last" =~ ^[0-9]+$ ]] || last=0
  local now
  now="$(now_epoch)"
  (( now - last >= COOLDOWN_SECONDS ))
}

mark_primed() {
  now_epoch > "$STATE_FILE" 2>/dev/null || true
}

STATUS_LINE="$(
  osascript <<'APPLESCRIPT'
on readStatusWithoutClick()
  tell application "System Events"
    tell process "Posturr"
      if not (exists menu bar 1) then return ""
      set mb to menu bar 1
      if (count of menu bar items of mb) is 0 then return ""

      repeat with mbi in menu bar items of mb
        try
          if exists menu 1 of mbi then
            set m to menu 1 of mbi
            if (exists menu item "Enable" of m) and (exists menu item "Recalibrate" of m) then
              return name of menu item 1 of m
            end if
          end if
        end try
      end repeat
    end tell
  end tell
  return ""
end readStatusWithoutClick

on readStatusWithClick()
  tell application "System Events"
    tell process "Posturr"
      if not (exists menu bar 1) then return ""
      set mb to menu bar 1
      if (count of menu bar items of mb) is 0 then return ""

      repeat with mbi in menu bar items of mb
        try
          click mbi
          delay 0.15
          if exists menu 1 of mbi then
            set m to menu 1 of mbi
            if (exists menu item "Enable" of m) and (exists menu item "Recalibrate" of m) then
              set firstLine to name of menu item 1 of m
              key code 53 -- ESC
              return firstLine
            end if
          end if
          key code 53
        end try
      end repeat
    end tell
  end tell
  return ""
end readStatusWithClick

set s to readStatusWithoutClick()
if s is not "" then return s
return "" -- let bash decide whether to do the "priming" click
APPLESCRIPT
)"

# If not readable, prime occasionally (one click every COOLDOWN_SECONDS max)
if [[ -z "${STATUS_LINE}" ]] && should_prime; then
  STATUS_LINE="$(
    osascript <<'APPLESCRIPT'
tell application "System Events"
  tell process "Posturr"
    if not (exists menu bar 1) then return ""
    set mb to menu bar 1
    if (count of menu bar items of mb) is 0 then return ""

    repeat with mbi in menu bar items of mb
      try
        click mbi
        delay 0.15
        if exists menu 1 of mbi then
          set m to menu 1 of mbi
          if (exists menu item "Enable" of m) and (exists menu item "Recalibrate" of m) then
            set firstLine to name of menu item 1 of m
            key code 53
            return firstLine
          end if
        end if
        key code 53
      end try
    end repeat
  end tell
end tell
return ""
APPLESCRIPT
  )"
  # Mark primed if we successfully read something
  [[ -n "${STATUS_LINE}" ]] && mark_primed
fi

# Fallback if still empty
if [[ -z "${STATUS_LINE}" ]]; then
  sketchybar --set "${NAME}" icon="${ICON}" label="Posturr" icon.color="0xFFC6D0F5"
  exit 0
fi

LABEL="${STATUS_LINE#Status: }"
COLOR="0xFFC6D0F5"

if [[ "${STATUS_LINE}" == *"Good Posture"* ]]; then
  COLOR="0xFFA6D189"
  LABEL="Good Posture"
  ICON="󱉉"
elif [[ "${STATUS_LINE}" == *"Slouch"* ]]; then
  COLOR="0xFFE78284"
  LABEL="SHRIMPING!"
  ICON="🦐"
fi

sketchybar --set "${NAME}" icon="${ICON}" label="${LABEL}" icon.color="${COLOR}" label.color="${COLOR}"

