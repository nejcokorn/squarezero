# Setup Guide

This file explains how to install these guidelines in another repository. It is
not a second source of agent instructions; the only instruction file is
`AGENTS.md`.

## Target Structure

```text
AGENTS.md
CLAUDE.md
```

Do not install these guidelines as `.ai-guidelines/`. The target project should
keep the instructions directly in its root `AGENTS.md`. `CLAUDE.md` should only
include `AGENTS.md` for Claude compatibility.

## Quick Install

Run this from the root of the repository where you want to use these guidelines:

```bash
curl -fsSL https://raw.githubusercontent.com/nejcokorn/agentguidelines/main/scripts/install.sh | sh
```

The installer will:

- create `AGENTS.md` if it does not exist
- replace `AGENTS.md` with the current guidelines if it already exists
- create or replace `CLAUDE.md` so it includes `AGENTS.md`

To use a different branch, source URL, or output file:

```bash
AGENT_GUIDELINES_BRANCH=main \
AGENT_GUIDELINES_FILE=AGENTS.md \
AGENT_GUIDELINES_CLAUDE_FILE=CLAUDE.md \
AGENT_GUIDELINES_SOURCE_URL=https://raw.githubusercontent.com/nejcokorn/agentguidelines/main/AGENTS.md \
sh /path/to/guidelines/scripts/install.sh
```

When running from a local clone, the installer copies the local `AGENTS.md`.
When running through `curl`, it downloads `AGENTS.md` from the configured source
URL.
