#!/bin/bash

# Read JSON input once
input=$(cat)

# Get git info from existing script
git_info=$(echo "$input" | bash ~/.claude/statusline-command.sh)

# Get context window used percentage (pre-calculated field)
used_pct=$(echo "$input" | grep -o '"used_percentage":[0-9.]*' | head -1 | grep -o '[0-9.]*')

# Combine outputs
if [ -n "$used_pct" ]; then
  printf '%s | Ctx: \033[01;33m%.0f%%\033[00m' "$git_info" "$used_pct"
else
  printf '%s' "$git_info"
fi
