#!/bin/sh

toggle_popup() {
  current="$(sketchybar --query "$NAME" | jq -r '.popup.drawing')"

  if [ "$current" = "on" ]; then
    sketchybar --set "$NAME" popup.drawing=off background.color=0xFF414559 icon.color=0xFFcad3f5
  else
    sketchybar --set "$NAME" popup.drawing=on background.color=0xFFf0c6c6 icon.color=0xCC414559 popup.background.corner_radius=8 popup.align=right popup.blur_radius=40 popup.background.color=0xCC414559 popup.y_offset=4

  fi
}

close_popup() {
  sketchybar --set power popup.drawing=off
}

run_action() {
  case "$1" in
    sleep)
      osascript -e 'tell application "System Events" to sleep'
      ;;
    restart)
      osascript -e 'tell application "System Events" to restart'
      ;;
    shutdown)
      osascript -e 'tell application "System Events" to shut down'
      ;;
  esac
}

case "$NAME" in
  power)
    if [ "$SENDER" = "mouse.clicked" ]; then
        toggle_popup
    fi
    ;;
  power.sleep)
    if [ "$SENDER" = "mouse.clicked" ]; then
      close_popup
      run_action sleep
    fi
    ;;
  power.restart)
    if [ "$SENDER" = "mouse.clicked" ]; then
      close_popup
      run_action restart
    fi
    ;;
  power.shutdown)
    if [ "$SENDER" = "mouse.clicked" ]; then
      close_popup
      run_action shutdown
    fi
    ;;
esac
