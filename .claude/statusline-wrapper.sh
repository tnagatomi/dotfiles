#!/bin/bash

CCUSAGE=(bunx ccusage)

input=$(cat)

# Line 1: git info
git_info=$(echo "$input" | bash ~/.claude/statusline-command.sh)

# Line 2: ccusage status
ccusage_info=$(echo "$input" | "${CCUSAGE[@]}" statusline --cost-source cc --no-offline 2>/dev/null)

# Line 3: per-model cost of the current session
session_id=$(echo "$input" | jq -r '.session_id // empty' 2>/dev/null)
model_costs=""
if [ -n "$session_id" ]; then
  model_costs=$("${CCUSAGE[@]}" session --json 2>/dev/null | jq -r --arg s "$session_id" '
    ((.session[] | select(.period==$s) | .modelBreakdowns) // [])
    | sort_by(-.cost)
    | map(
        (.modelName
          | sub("^claude-"; "") | sub("-[0-9]{8}$"; "")
          | (try (capture("^(?<fam>[a-z]+)-(?<ver>[0-9].*)$")
                  | ((.fam[0:1] | ascii_upcase) + .fam[1:]) + " " + (.ver | gsub("-"; ".")))
             catch .))
        + " $" + ((.cost*100|round) as $c |
                  ($c/100|floor|tostring) + "." + ($c%100 | tostring | if length<2 then "0"+. else . end))
      )
    | if length>0 then "📊 " + join("  ·  ") else empty end
  ' 2>/dev/null)
fi

out="$git_info"
[ -n "$ccusage_info" ] && out="$out
$ccusage_info"
[ -n "$model_costs" ] && out="$out
$model_costs"
printf '%s' "$out"
