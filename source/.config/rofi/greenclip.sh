#!/bin/bash
~/.config/greenclip/greenclip print | awk '{print $0}' | dmenu -i -p "Clipboard" | xargs -r greenclip select
