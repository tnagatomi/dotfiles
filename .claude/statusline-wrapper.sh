#!/bin/bash

CCUSAGE=(npx -y ccusage)

# Read JSON input once
input=$(cat)

# Line 1: git info from existing script
git_info=$(echo "$input" | bash ~/.claude/statusline-command.sh)

# Line 2: ccusage status (session/today/block cost, burn rate, context) - fail-safe.
# The "session" cost mirrors Claude Code's own total_cost_usd, so it is the
# real-time cost of the current session regardless of model (Fable etc.).
ccusage_info=$(echo "$input" | "${CCUSAGE[@]}" statusline --cost-source cc 2>/dev/null)

# Line 3: per-model cost of the CURRENT session. Uses ccusage's own pricing
# (offline cache), since Claude Code's total is not broken down by model.
session_id=$(echo "$input" | jq -r '.session_id // empty' 2>/dev/null)
model_costs=""
if [ -n "$session_id" ]; then
  model_costs=$("${CCUSAGE[@]}" session --json --offline 2>/dev/null | jq -r --arg s "$session_id" '
    ((.session[] | select(.period==$s) | .modelBreakdowns) // [])
    | sort_by(-.cost)
    | map(
        (.modelName
          | if test("opus";"i") then "Opus"
            elif test("sonnet";"i") then "Sonnet"
            elif test("haiku";"i") then "Haiku"
            elif test("fable";"i") then "Fable"
            else . end)
        + " $" + ((.cost*100|round)/100|tostring)
      )
    | if length>0 then "📊 " + join("  ·  ") else empty end
  ' 2>/dev/null)
fi

# Combine on separate lines so nothing gets truncated. ccusage already shows the
# context window (🧠), so the previous custom "Ctx: X%" segment is dropped.
out="$git_info"
[ -n "$ccusage_info" ] && out="$out
$ccusage_info"
[ -n "$model_costs" ] && out="$out
$model_costs"
printf '%s' "$out"
