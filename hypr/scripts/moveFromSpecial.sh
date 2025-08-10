#!/bin/bash

# Set source workspace (special one)
SOURCE_WORKSPACE="special:magic"

# Get current (target) workspace ID
CURRENT_WORKSPACE=$(hyprctl activeworkspace -j | jq '.id')

# Get all windows on the special workspace and move them to current
hyprctl clients -j | jq -r \
  --arg src "$SOURCE_WORKSPACE" \
  '.[] | select(.workspace.name == $src) | .address' | while read -r win; do
    hyprctl dispatch movetoworkspacesilent "$CURRENT_WORKSPACE,address:$win"
done

