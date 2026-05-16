#!/usr/bin/env sh
set -eu

AGENTS_FILE="${AGENT_GUIDELINES_FILE:-AGENTS.md}"
BRANCH="${AGENT_GUIDELINES_BRANCH:-main}"
AGENTS_SOURCE_URL="${AGENT_GUIDELINES_SOURCE_URL:-https://raw.githubusercontent.com/nejcokorn/agentguidelines/$BRANCH/AGENTS.md}"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
LOCAL_AGENTS_SOURCE="$SCRIPT_DIR/../AGENTS.md"

TMP_SOURCE="$(mktemp)"

cleanup() {
  rm -f "$TMP_SOURCE"
}
trap cleanup EXIT HUP INT TERM

if [ -f "$LOCAL_AGENTS_SOURCE" ]; then
  cp "$LOCAL_AGENTS_SOURCE" "$TMP_SOURCE"
elif command -v curl >/dev/null 2>&1; then
  curl -fsSL "$AGENTS_SOURCE_URL" -o "$TMP_SOURCE"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$TMP_SOURCE" "$AGENTS_SOURCE_URL"
else
  echo "curl or wget is required to download AGENTS.md."
  exit 1
fi

cp "$TMP_SOURCE" "$AGENTS_FILE"

echo "Updated $AGENTS_FILE with agent guidelines."
