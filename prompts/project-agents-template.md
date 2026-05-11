# AGENTS.md

Use this file as the root `AGENTS.md` template in projects that consume SquareZero
guidelines.

Keep this file short. AI Agent loads `AGENTS.md` automatically as project
instructions, so this file should point to the detailed guidelines instead of
copying all of them inline.

## Project Instructions

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

These guidelines are mandatory unless the user explicitly overrides them.

## Project Access

The AI Agent may read and edit files anywhere in this target project. The
`.ai-guidelines` directory is the SquareZero submodule and should be treated as
shared guidance unless the task is specifically to update SquareZero itself.

## Local Project Memory

Before making implementation changes, also read:

- `AI_PROJECT_MEMORY.md`

If the file does not exist, create it when the user makes a durable project
decision.

Update `AI_PROJECT_MEMORY.md` whenever the user agrees to a project-level decision
that should affect future prompts. Examples:

- The project is a backend-only service.
- The backend lives in one folder and the frontend lives in another folder.
- A frontend project must call a specific backend project or API base URL.
- The project uses a specific authentication, authorization, deployment, or
  data ownership model.
- The user chooses a convention that differs from the default SquareZero
  guidelines.

Do not store secrets, credentials, private tokens, or temporary implementation
details in project memory.

## Repository Expectations

- Inspect the existing codebase before making changes.
- Read and edit files anywhere in the target project, not only inside the
  `.ai-guidelines` submodule.
- Read local project memory before choosing architecture or folder structure.
- Follow existing project conventions.
- Keep implementation changes scoped to the requested task.
- Run the relevant lint, typecheck, and test commands when available.
- Report any verification that could not be completed.
- Commit completed changes and push them when the project has a Git remote.
