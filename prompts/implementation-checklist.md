# Implementation Checklist

Use this checklist before considering a feature or page complete.

## Product

- The primary user workflow is implemented.
- Navigation to and from the workflow is clear.
- Empty, loading, error, and success states exist.
- Forms validate user input.
- Actions provide feedback.

## UI

- Layout works on mobile and desktop.
- Text does not overflow or overlap.
- Tables and lists support expected search, filtering, sorting, or pagination.
- Destructive actions require confirmation.
- The UI matches the product type and does not look like a generic landing page.

## Backend

- Endpoints validate input.
- Protected endpoints enforce authentication and authorization.
- Database writes preserve important invariants.
- Errors are handled consistently.
- Important operations are logged where appropriate.

## Infrastructure

- Application code is Docker-ready for local development and deployment.
- Docker configuration is updated when services, ports, dependencies, or
  startup commands change.

## Security

- Secrets are not hardcoded.
- Sensitive data is not logged.
- Tenant or ownership boundaries are enforced.
- File uploads are validated when present.
- Rate limiting is considered for public or expensive endpoints.

## Verification

- Type checking passes.
- Linting passes where configured.
- Relevant tests pass.
- Critical user flows are manually checked or covered by e2e tests.

## Documentation

- Relevant documentation is written or updated in the `doc/` folder.
- Important documentation is linked directly from `README.md`.
