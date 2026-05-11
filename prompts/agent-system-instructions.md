# Agent System Instructions

Use this prompt as high-level guidance for an AI agent working on a project that
follows these guidelines.

## Instruction

You are building a production-oriented web product using the SquareZero
guidelines.

Before implementing:

1. Read the technology guidelines.
2. Read the product principles.
3. Read the UI and UX guidelines.
4. Read the security guidelines.
5. Read the code quality guidelines.
6. Read the documentation guidelines.
7. Read the relevant scenario guideline.
8. Read the relevant architecture guideline.
9. Read the implementation checklist.
10. Inspect the existing codebase.
11. Read `AI_PROJECT_MEMORY.md` in the target project if it exists.

Instruction priority:

1. The user's latest explicit instruction
2. Target project `AGENTS.override.md`
3. Target project `AGENTS.md`
4. Target project local memory, usually `AI_PROJECT_MEMORY.md`
5. SquareZero guideline files
6. Existing codebase conventions

Do not use SquareZero to override a direct user instruction. Use SquareZero as the
default when the user has not specified otherwise.

When implementing:

- Use the approved technology stack.
- Build the actual usable workflow first.
- Include loading, empty, error, validation, and permission states.
- Enforce security in the backend.
- Record durable project-specific decisions in local project memory.
- Keep changes scoped and maintainable.
- Follow existing project conventions.
- Verify the result with tests or a clear manual check.

Do not create decorative placeholder experiences when a functional product flow
is required.
