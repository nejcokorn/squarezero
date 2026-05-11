# Setup Guide

This is for setting up SquareZero guidelines in another repository.
Implementation agents should not treat this file as product, architecture, UI,
or security guidance.

## Goal

Make the SquareZero guidelines available inside another project so an AI agent can
read and follow them before implementation work starts.

## Recommended Setup

The most reliable approach for AI Agent is to keep a short `AGENTS.md` file in the
root of every project that uses these guidelines.

AI Agent discovers `AGENTS.md` automatically. It reads global instructions first,
then project instructions from the repository root down to the current working
directory. Instructions closer to the current directory appear later and can
override earlier guidance.

Recommended target project structure:

```text
AGENTS.md
AI_PROJECT_MEMORY.md
.ai-guidelines/
```

Use `.ai-guidelines/` as the SquareZero Git submodule:

```text
.ai-guidelines/README.md
```

Then add a short `AGENTS.md` in the project root:

```md
# AGENTS.md

## Project Instructions

Before making implementation changes, read and follow the SquareZero guidelines:

- `.ai-guidelines/README.md`
- `.ai-guidelines/01-technologies.md`
- `.ai-guidelines/02-general-product-principles.md`
- `.ai-guidelines/03-ui-ux-guidelines.md`
- `.ai-guidelines/04-security.md`
- `.ai-guidelines/05-code-quality.md`
- `.ai-guidelines/doc/documentation.md`
- `.ai-guidelines/scenarios/`
- `.ai-guidelines/architecture/`
- `.ai-guidelines/prompts/implementation-checklist.md`
- `AI_PROJECT_MEMORY.md`

These guidelines are mandatory unless the user explicitly overrides them.
```

Keep `AGENTS.md` small. It should point to the guideline files instead of
copying all guideline content into one large instruction file.

The target project should also keep a local project memory file:

```text
AI_PROJECT_MEMORY.md
```

This file records durable project-specific decisions.

## Quick Install

Run this from the root of the repository where you want to use SquareZero:

```bash
curl -fsSL https://raw.githubusercontent.com/nejcokorn/squarezero/main/scripts/install.sh | sh
```

The installer will:

- initialize Git in the target project if needed
- install or update SquareZero as a Git submodule in `.ai-guidelines/`
- create `AI_PROJECT_MEMORY.md` if it does not exist
- create or update `AGENTS.md`
- preserve existing `AGENTS.md` content outside the SquareZero managed block
- migrate an old `.ai-guidelines/ai-project-memory.md` file to
  `AI_PROJECT_MEMORY.md` when present

The installer keeps project-specific notes in `AI_PROJECT_MEMORY.md`, not inside
the `.ai-guidelines/` submodule.

To use a different branch, repository, or target path:

```bash
SQUAREZERO_BRANCH=main \
SQUAREZERO_REPO_URL=https://github.com/nejcokorn/squarezero.git \
SQUAREZERO_TARGET_DIR=.ai-guidelines \
SQUAREZERO_MEMORY_FILE=AI_PROJECT_MEMORY.md \
SQUAREZERO_AGENTS_FILE=AGENTS.md \
sh /path/to/squarezero/scripts/install.sh
```

When running the script from a local clone of SquareZero instead of `curl`, use:

```bash
sh /path/to/squarezero/scripts/install.sh
```

## Option 1: Git Submodule

Use a Git submodule when you want one central SquareZero repository shared across
many projects.

Target paths:

```text
.ai-guidelines/
```

Example:

```bash
git submodule add https://github.com/nejcokorn/squarezero.git .ai-guidelines
git submodule update --init --recursive
```

After cloning a project that uses the submodule:

```bash
git submodule update --init --recursive
```

The target project should still contain a root `AGENTS.md` that points to the
submodule path. AI Agent will not automatically treat arbitrary linked
documentation as project instructions unless a discovered instruction file tells
it where to look.

Keep target-project memory in `AI_PROJECT_MEMORY.md`, not inside the submodule.

## Option 2: Copy The Guidelines

Copy this repository into the target project only when Git submodules are not an
option.

Target paths:

```text
.ai-guidelines/
```

Tradeoff: updates must be copied manually.

## Option 3: External Repository Reference

You can reference the SquareZero repository URL from another project, but this is
less reliable.

```md
Before implementation, read and follow:
https://github.com/nejcokorn/squarezero
```

Tradeoff: the agent may not have network access, may not browse external links,
or may not automatically fetch the repository.

## Suggested Target Project File

Create this file in projects that use SquareZero:

```text
AGENTS.md
```

Suggested content is available in:

```text
prompts/project-agents-template.md
```

Minimal content:

```md
# AGENTS.md

Before making changes, read `.ai-guidelines/README.md` and follow the
implementation reading order defined there.

Also read `AI_PROJECT_MEMORY.md` if it exists. Update it when the user agrees to
a durable project-level decision.

Do not skip the relevant scenario and architecture files.
```
