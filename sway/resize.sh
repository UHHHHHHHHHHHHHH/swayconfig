#!/bin/bash
direction=$1

# Get focused window's position and workspace dimensions
eval $(swaymsg -t get_tree | jq -r '
  .. | select(.focused? == true) | 
  "ww=\(.rect.width); wx=\(.rect.x); ww_workspace=\(.deco_rect.width)"'
)

# Threshold to detect edge (adjust if needed)
edge_threshold=50

case $direction in
  left)
    if (( wx <= edge_threshold )); then
      swaymsg resize set width 66 ppt
    else
      swaymsg move left
    fi
    ;;
  right)
    right_edge=$((wx + ww))
    if (( right_edge >= (ww_workspace - edge_threshold) )); then
      swaymsg resize set width 66 ppt
    else
      swaymsg move right
    fi
    ;;
esac
