# Project-memory protocol

Project memory lives under `.ai/project-memory/`.

## Read

Always read `.ai/project-memory/README.md` first. Then load only the files needed for the current task.

## Freshness

Memory entries should record verification date and source paths when practical.

Example:

```md
---
verified: 2026-09-19
sources:
  - src/auth/
  - src/middleware/auth.ts
---
```

## Incremental invalidation

Do not re-explore the whole codebase after a small change.

1. Identify what changed.
2. Map changed paths to memory entries.
3. Refresh only affected entries.
4. Leave unrelated memory untouched.

## Write policy

Exploration agents may report proposed memory changes, but do not directly mutate persistent memory unless the user has approved the update.

Present updates as a small patch-like proposal:

- file to change
- exact information to add/remove
- source paths
- why the update matters

## Memory scope

Persist stable knowledge that prevents future rediscovery:
- architecture
- component responsibilities
- important flows
- API/event contracts
- data model overview
- conventions
- decisions
- testing locations/maps

Do not persist every observation, temporary task state, or copied file contents.
