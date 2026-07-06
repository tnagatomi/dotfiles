#!/usr/bin/env bash
# Fired on the worktree.created event.
# Sets up work/claude/codex/dev tabs in the newly created worktree workspace,
# and auto-launches claude in the claude tab and codex in the codex tab.
#
# Event JSON shape (HERDR_PLUGIN_EVENT_JSON):
#   {"event":"worktree_created","data":{"workspace":{"workspace_id":...,
#     "active_tab_id":...,"tab_count":...}, "worktree":{...}}}
set -euo pipefail

HERDR="${HERDR_BIN_PATH:-herdr}"

# Extract workspace_id / first tab / tab count from the event JSON
read -r ws t1 tab_count <<EOF
$(printf '%s' "${HERDR_PLUGIN_EVENT_JSON:-}" | python3 -c '
import sys, json
try:
    ws = json.load(sys.stdin)["data"]["workspace"]
except Exception:
    print("  0"); sys.exit(0)
print(ws.get("workspace_id", ""), ws.get("active_tab_id", ""), ws.get("tab_count", 0))
')
EOF

[ -n "${ws:-}" ] || exit 0
[ -n "${t1:-}" ] || exit 0
# A fresh worktree workspace has exactly one tab. Skip if it already has more,
# to avoid creating duplicate tabs.
[ "${tab_count:-0}" = "1" ] || exit 0

# Rename tab 1 to "work"
"$HERDR" tab rename "$t1" work >/dev/null

# Create claude / codex / dev tabs (capture root pane ids)
p_claude="$("$HERDR" tab create --workspace "$ws" --label claude --no-focus \
  | python3 -c 'import sys,json;print(json.load(sys.stdin)["result"]["root_pane"]["pane_id"])')"
p_codex="$("$HERDR" tab create --workspace "$ws" --label codex --no-focus \
  | python3 -c 'import sys,json;print(json.load(sys.stdin)["result"]["root_pane"]["pane_id"])')"
"$HERDR" tab create --workspace "$ws" --label dev --no-focus >/dev/null

# Auto-launch the agents
"$HERDR" pane run "$p_claude" claude
"$HERDR" pane run "$p_codex" codex

# Return focus to the work tab
"$HERDR" tab focus "$t1" >/dev/null
