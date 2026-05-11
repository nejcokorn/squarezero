# Technology Guidelines

Use the following technologies when building services, web applications,
additional features, or fixes.

These are the default choices. Only use different technologies when the user
explicitly requests them or the existing project already uses a different stack.

## Backend

### API Framework

- NestJS

### Database

- PostgreSQL
- Prisma

### Pub/Sub System

- Redis

### Queue And Job Processing

- BullMQ

### Validation

- NestJS DTO validation
- `class-validator` and `class-transformer` unless the project standardizes on
  another validation approach

### Authentication And Authorization

- Use secure session or token-based authentication depending on the product.
- Use role-based access control or permission-based access for protected
  systems.
- Authorization must be enforced in the backend.

## Frontend

- Next.js
- TypeScript
- Tailwind
- TanStack Query

### Frontend Defaults

- Use React Server Components where they fit the Next.js application model.
- Use client components for interactive UI.
- Use TanStack Query for server state, caching, refetching, and mutations.
- Use Tailwind for styling and responsive layout.
- Avoid adding a UI framework unless the project already uses one or the user
  requests it.

## Infrastructure

- Docker
- AWS
- Terraform

### Docker

Application code must be Docker-ready. When adding or changing services, make
sure the project can be built and run through Docker for local development and
deployment.

Use separate containers for:

- API: NestJS, Prisma, and related backend dependencies
- Database: PostgreSQL
- Cache and pub/sub: Redis
- Job processing: BullMQ worker process
- Frontend: Next.js

### AWS

Use AWS with Terraform for infrastructure provisioning.

Prefer managed services where they reduce operational burden:

- RDS for PostgreSQL
- ElastiCache for Redis
- ECS, EKS, or another agreed container runtime for services
- S3 for object storage
- CloudFront for public asset delivery where appropriate
- CloudWatch or an equivalent logging and monitoring setup

## Testing

- Backend unit and integration tests
- API e2e tests for critical flows
- Frontend component tests when useful
- Playwright for important browser workflows

## Package And Tooling Defaults

- Use the package manager already present in the project.
- Do not switch package managers unless requested.
- Use linting, formatting, and type checking before considering work complete.
