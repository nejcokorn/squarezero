#!/usr/bin/env sh
set -eu

REPO_URL="${SQUAREZERO_REPO_URL:-https://github.com/nejcokorn/squarezero.git}"
TARGET_DIR="${SQUAREZERO_TARGET_DIR:-.ai-guidelines}"
MEMORY_FILE="${SQUAREZERO_MEMORY_FILE:-.ai-guidelines/ai-project-memory.md}"
AGENTS_FILE="${SQUAREZERO_AGENTS_FILE:-AGENTS.md}"
BRANCH="${SQUAREZERO_BRANCH:-main}"
TMP_DIR=""

cleanup() {
  if [ -n "$TMP_DIR" ] && [ -d "$TMP_DIR" ]; then
    rm -rf "$TMP_DIR"
  fi
}

trap cleanup EXIT INT TERM

if [ -e "$TARGET_DIR/.git" ]; then
  echo "$TARGET_DIR is a Git repository or submodule. Update it with git instead."
  exit 1
fi

if command -v git >/dev/null 2>&1; then
  TMP_DIR="$(mktemp -d)"
  git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$TMP_DIR/squarezero" >/dev/null 2>&1 || {
    echo "Failed to clone $REPO_URL branch $BRANCH."
    exit 1
  }
  rm -rf "$TMP_DIR/squarezero/.git"
  if [ -f "$MEMORY_FILE" ]; then
    mkdir -p "$TMP_DIR/preserve"
    cp "$MEMORY_FILE" "$TMP_DIR/preserve/ai-project-memory.md"
  fi
  rm -rf "$TARGET_DIR"
  mkdir -p "$TARGET_DIR"
  cp -R "$TMP_DIR/squarezero/." "$TARGET_DIR/"
  if [ -f "$TMP_DIR/preserve/ai-project-memory.md" ]; then
    mkdir -p "$(dirname "$MEMORY_FILE")"
    cp "$TMP_DIR/preserve/ai-project-memory.md" "$MEMORY_FILE"
  fi
else
  echo "git is required to install SquareZero guidelines."
  exit 1
fi

mkdir -p "$(dirname "$MEMORY_FILE")"

if [ ! -f "$MEMORY_FILE" ]; then
  cat > "$MEMORY_FILE" <<'EOF'
# AI Project Memory

This file records durable project decisions for AI agents.

## Project Shape

- Not decided yet.

## Integration

- Not decided yet.

## Architecture Decisions

- Follow SquareZero defaults unless project-specific decisions are recorded here.

## Commands

- Install: not recorded yet
- Typecheck: not recorded yet
- Test: not recorded yet

## Overrides

- None.
EOF
fi

AGENTS_BLOCK_START="<!-- squarezero:start -->"
AGENTS_BLOCK_END="<!-- squarezero:end -->"

AGENTS_BLOCK="$(cat <<'EOF'
<!-- squarezero:start -->
## SquareZero Instructions

Before making implementation changes, read and follow the SquareZero guidelines:

1. `.ai-guidelines/README.md`
2. `.ai-guidelines/01-technologies.md`
3. `.ai-guidelines/02-general-product-principles.md`
4. `.ai-guidelines/03-ui-ux-guidelines.md`
5. `.ai-guidelines/04-security.md`
6. `.ai-guidelines/05-code-quality.md`
7. `.ai-guidelines/06-local-project-memory.md`
8. `.ai-guidelines/scenarios/`
9. `.ai-guidelines/architecture/`
10. `.ai-guidelines/prompts/implementation-checklist.md`

Also read `.ai-guidelines/ai-project-memory.md` before choosing architecture,
folder structure, or integration points. Update it when the user agrees to a
durable project-level decision.

These guidelines are mandatory unless the user explicitly overrides them.
<!-- squarezero:end -->
EOF
)"

if [ ! -f "$AGENTS_FILE" ]; then
  {
    echo "# AGENTS.md"
    echo
    printf '%s\n' "$AGENTS_BLOCK"
  } > "$AGENTS_FILE"
elif grep -q "$AGENTS_BLOCK_START" "$AGENTS_FILE"; then
  TMP_AGENTS="$(mktemp)"
  awk -v start="$AGENTS_BLOCK_START" -v end="$AGENTS_BLOCK_END" '
    $0 == start { skipping = 1; next }
    $0 == end { skipping = 0; next }
    skipping != 1 { print }
  ' "$AGENTS_FILE" > "$TMP_AGENTS"
  {
    cat "$TMP_AGENTS"
    echo
    printf '%s\n' "$AGENTS_BLOCK"
  } > "$AGENTS_FILE"
  rm -f "$TMP_AGENTS"
else
  {
    echo
    printf '%s\n' "$AGENTS_BLOCK"
  } >> "$AGENTS_FILE"
fi

echo "SquareZero installed into $TARGET_DIR."
echo "Updated $AGENTS_FILE."
echo "Project memory: $MEMORY_FILE."
