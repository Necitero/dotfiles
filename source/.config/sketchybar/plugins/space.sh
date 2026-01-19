#!/bin/sh

icon=""

case "$SELECTED" in
  true|1) icon="" ;;
esac

sketchybar --set "$NAME" icon="$icon"

