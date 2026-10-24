# Memory output

Return two sections.

## Findings

Structured facts with source paths.

## Memory proposal

Only stable, reusable knowledge that would save future discovery.

Example:

```yaml
memory_file: components/auth.md
change:
  - add refresh-token flow
sources:
  - src/auth/service.ts
  - src/middleware/auth.ts
reason: future planning needs the current auth boundary
```

Do not write the memory file directly unless the user has already approved persistent memory updates.
