#!/usr/bin/env sh
set -eu

REPO_URL="${SQUAREZERO_REPO_URL:-https://github.com/nejcokorn/squarezero.git}"
TARGET_DIR="${SQUAREZERO_TARGET_DIR:-.ai-guidelines}"
MEMORY_FILE="${SQUAREZERO_MEMORY_FILE:-AI_PROJECT_MEMORY.md}"
AGENTS_FILE="${SQUAREZERO_AGENTS_FILE:-AGENTS.md}"
BRANCH="${SQUAREZERO_BRANCH:-main}"
OLD_MEMORY_FILE="$TARGET_DIR/ai-project-memory.md"

if ! command -v git >/dev/null 2>&1; then
  echo "git is required to install SquareZero guidelines."
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git init >/dev/null
  echo "Initialized Git repository."
fi

if [ -f "$OLD_MEMORY_FILE" ] && [ ! -f "$MEMORY_FILE" ]; then
  mkdir -p "$(dirname "$MEMORY_FILE")"
  cp "$OLD_MEMORY_FILE" "$MEMORY_FILE"
  echo "Migrated $OLD_MEMORY_FILE to $MEMORY_FILE."
fi

if git config -f .gitmodules --get "submodule.$TARGET_DIR.path" >/dev/null 2>&1; then
  git submodule update --init --recursive "$TARGET_DIR"
elif [ -e "$TARGET_DIR" ]; then
  echo "Replacing existing $TARGET_DIR with a SquareZero Git submodule."
  rm -rf "$TARGET_DIR"
  git submodule add -b "$BRANCH" "$REPO_URL" "$TARGET_DIR"
else
  git submodule add -b "$BRANCH" "$REPO_URL" "$TARGET_DIR"
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
7. `.ai-guidelines/doc/documentation.md`
8. `.ai-guidelines/scenarios/`
9. `.ai-guidelines/architecture/`
10. `.ai-guidelines/prompts/implementation-checklist.md`

Also read `AI_PROJECT_MEMORY.md` before choosing architecture, folder structure,
or integration points. Update it when the user agrees to a durable project-level
decision.

The AI Agent may read and edit files anywhere in this target project. The
`.ai-guidelines` directory is the SquareZero submodule and should be treated as
shared guidance unless the task is specifically to update SquareZero itself.

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

echo "SquareZero installed as a Git submodule in $TARGET_DIR."
echo "Updated $AGENTS_FILE."
echo "Project memory: $MEMORY_FILE."
