#!/bin/bash

# Read JSON input once
input=$(cat)

# Get git info from existing script
git_info=$(echo "$input" | bash ~/.claude/statusline-command.sh)

# Get context percentage and ccusage from ccstatusline
ccstatusline=$(echo "$input" | npx ccstatusline)

# Combine outputs
printf '%s | %s' "$git_info" "$ccstatusline"
