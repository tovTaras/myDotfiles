#!/bin/bash

# Set target workspace
TARGET_WORKSPACE=special:magic

# Get current workspace ID
CURRENT_WORKSPACE=$(hyprctl activeworkspace -j | jq '.id')

# Get all windows on current workspace
hyprctl clients -j | jq -r \
  --argjson ws "$CURRENT_WORKSPACE" \
  --arg tgt "$TARGET_WORKSPACE" \
  '.[] | select(.workspace.id == $ws) | .address' | while read -r win; do
    hyprctl dispatch movetoworkspacesilent "$TARGET_WORKSPACE,address:$win"
done

