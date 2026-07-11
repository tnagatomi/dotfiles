#!/bin/bash
# MessageDisplay hook: append the session cost (via ccusage) to the displayed
# assistant message in Claude Code Desktop.
set -uo pipefail

input=$(cat)

# Only decorate the final chunk of a message; let intermediate deltas pass through.
[ "$(printf '%s' "$input" | jq -r '.final // false')" = "true" ] || exit 0

# Desktop only: transcript entries record which client wrote them
# (claude-desktop / cli).
transcript=$(printf '%s' "$input" | jq -r '.transcript_path // empty')
{ [ -n "$transcript" ] && [ -f "$transcript" ]; } || exit 0
entrypoint=$(tail -50 "$transcript" | jq -rs '[.[] | .entrypoint? // empty] | last // empty' 2>/dev/null)
[ "$entrypoint" = "claude-desktop" ] || exit 0

# ccusage statusline expects the CLI statusline input schema, whose `model`
# field is required. Costs are computed from the transcript; the model only
# feeds the 🤖 and 🧠 segments, which are stripped below — a placeholder is
# fine. --no-offline fetches current pricing so brand-new models aren't
# costed at $0 by the pricing snapshot embedded in the ccusage binary.
line=$(printf '%s' "$input" | jq -c '
  . + {
    model: {id: "unknown", display_name: "unknown"},
    workspace: {current_dir: (.cwd // "."), project_dir: (.cwd // ".")}
  }' | bunx ccusage statusline --no-offline 2>/dev/null) || line=""
[ -n "$line" ] || exit 0

# Keep only session and today costs.
line=$(printf '%s' "$line" | sed -E -e 's/^🤖 [^|]*\| //' -e 's| / [^/|]*block[^|]*||' -e 's/ ?\| 🔥 [^|]*//' -e 's/ ?\| 🧠 .*$//')

# Per-model cost breakdown for this session (session id is reported as `period`
# in ccusage's grouped session JSON).
sid=$(printf '%s' "$input" | jq -r '.session_id // empty')
breakdown=$(bunx ccusage session --json 2>/dev/null | jq -r --arg sid "$sid" '
  [.session[] | select(.period == $sid) | .modelBreakdowns[]]
  | sort_by(-.cost)
  | map((.modelName | sub("^claude-"; "") | sub("-[0-9]{8}$"; "")) + " $" +
        ((.cost * 100 | round) as $c |
         ($c / 100 | floor | tostring) + "." + ($c % 100 | tostring | if length < 2 then "0" + . else . end)))
  | join(" · ")' 2>/dev/null) || breakdown=""
[ -n "$breakdown" ] && line="$line
📊 $breakdown"

printf '%s' "$input" | jq -c --arg line "$line" '{
  hookSpecificOutput: {
    hookEventName: "MessageDisplay",
    displayContent: ((.delta // "") + "\n\n---\n" + $line)
  }
}'
exit 0
