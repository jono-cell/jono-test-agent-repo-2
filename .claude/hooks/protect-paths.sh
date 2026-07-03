#!/usr/bin/env bash
# PreToolUse guardrail: block edits to protected paths.
#
# Claude Code passes the tool call as JSON on stdin. We inspect the target
# file path and exit non-zero to BLOCK the action; the message on stderr is
# fed back to Claude as feedback so it knows why it was stopped.

set -euo pipefail

payload="$(cat)"

# Extract the file path from the tool input (Edit/Write put it in file_path).
# Uses jq if available; falls back to grep so the hook still works without it.
if command -v jq >/dev/null 2>&1; then
  target="$(printf '%s' "$payload" | jq -r '.tool_input.file_path // empty')"
else
  target="$(printf '%s' "$payload" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*:"//;s/"$//')"
fi

# Glob patterns that must never be edited by the agent.
protected=(
  "*/package-lock.json"
  "*.env"
  "*/secrets/*"
)

for pattern in "${protected[@]}"; do
  # shellcheck disable=SC2053
  if [[ "$target" == $pattern ]]; then
    echo "BLOCKED: '$target' is a protected path and must not be edited by the agent." >&2
    exit 2   # non-zero exit blocks the tool call
  fi
done

exit 0   # allow the tool call
