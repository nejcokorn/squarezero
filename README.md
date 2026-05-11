# SquareZero AI Agent Guidelines

SquareZero is a SquareBase project.

SquareZero represents the starting point for every project. The name is
inspired by `x^0 = 1`: no matter what project `x` becomes, these guidelines
provide the first stable baseline.

This repository contains reusable guidelines for AI agents that build web pages,
single page applications, CRM systems, SaaS products, admin panels, APIs, and
supporting infrastructure.

The purpose of these files is to make AI-generated work consistent,
production-oriented, secure, and aligned with the preferred technology stack.

## Instruction Priority

When instructions conflict, apply them in this order:

1. The user's latest explicit instruction
2. Target project `AGENTS.override.md`
3. Target project `AGENTS.md`
4. Target project local memory, usually `AI_PROJECT_MEMORY.md`
5. SquareZero guideline files
6. Existing codebase conventions

Do not use SquareZero to override a direct user instruction. Use SquareZero as the
default when the user has not specified otherwise.

## Reading Order

Implementation agents should read the files relevant to the current task in this
order before implementing a project:

1. `01-technologies.md`
2. `02-general-product-principles.md`
3. `03-ui-ux-guidelines.md`
4. `04-security.md`
5. `05-code-quality.md`
6. `doc/documentation.md`
7. `scenarios/`
8. `architecture/`
9. `prompts/implementation-checklist.md`

Do not include `setup.md` in the implementation reading order. That file is for
humans who want to connect these guidelines to another repository.

## Setup

For instructions on linking these guidelines to another project or repository,
read `setup.md`.

Quick install from the root of a target repository:

```bash
curl -fsSL https://raw.githubusercontent.com/nejcokorn/squarezero/main/scripts/install.sh | sh
```

## Core Rule

Build the actual usable product first. Do not default to a marketing landing
page, demo shell, placeholder dashboard, or decorative mockup unless the user
explicitly asks for that.

## Documentation

Write project documentation for implemented features and place it in the
[`doc/`](doc/documentation.md) folder.

## Project Types Covered

- CRM systems
- SaaS dashboards
- Single page applications
- Admin panels
- Landing pages
- Backend APIs
- Full-stack products

## Agent Expectations

The agent should:

- Inspect the existing codebase before making changes.
- Read and edit files anywhere in the target project where SquareZero is
  installed, not only inside the `.ai-guidelines` submodule.
- Follow the selected technologies unless the user explicitly overrides them.
- Prefer simple, maintainable implementation over unnecessary abstraction.
- Build complete flows with loading, empty, error, and permission states.
- Treat security, validation, and authorization as default requirements.
- Keep application code Docker-ready for local development and deployment.
- Record durable project-specific decisions in local project memory.
- Write or update documentation in the `doc/` folder for implemented features.
- Verify changes with tests or a clear manual verification path.
- Commit completed changes. If the target project does not have a Git
  repository, initialize one before committing.
- After committing, push the commit when the target project has a Git remote.
