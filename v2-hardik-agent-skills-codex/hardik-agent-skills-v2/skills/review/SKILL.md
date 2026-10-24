---
name: review
description: >
  Review implemented changes against the plan, requirements, repository conventions, and relevant
  tests. Use after implementation or when the user asks for code review. Read only the tests and
  files relevant to the changed area. Also detect project-memory entries that may now be stale.
---

# Review

1. Read the approved plan and relevant project-memory entries.
2. Inspect the changed files and actual diffs.
3. Check correctness, regressions, contracts, error paths, and repository conventions.
4. Read relevant tests; do not load the entire test suite into context.
5. Report concrete findings with severity and paths.
6. Identify project-memory entries invalidated by the change.
7. Propose precise memory updates and ask the user before persisting them.

Do not turn review into an architecture rewrite unless the implementation clearly violates an important requirement.

See:
- `references/review-checks.md`
- `references/memory-update.md`
