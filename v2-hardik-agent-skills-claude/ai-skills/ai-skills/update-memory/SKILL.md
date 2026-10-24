---
name: update-memory
description: Refresh project memory after codebase changes. Triggered by /update-memory. Diffs changed files since last explore, rewrites only stale memory files. Faster than full /explore. Also auto-suggested by /plan when meta.md is stale.
---

# Update Memory

Targeted refresh of `.ai/project-memory/`. Rewrites only stale files.

## Steps

1. Read `meta.md` → get `git_commit` + `explored` list.
2. Run `git diff --name-only <commit> HEAD` to find changed source files.
3. Map changed files to affected memory:

| Changed source area | Rewrite |
|---------------------|---------|
| Entry point, manifest, README | `overview.md` |
| Module boundary, shared interface | `architecture.md` |
| Route, schema, service contract | `flows.md` |
| Files inside a component | `components/<name>.md` |

4. For each stale memory file, spawn a read-only agent:
   - Reads changed source files in that area
   - Rewrites the memory file (same schema, updated facts)
   - → `../plan/references/harness-adapters.md` for agent setup
   - → `../explore/references/memory-schema.md` for file format

5. Update `meta.md` with new timestamp + current git commit.

Print: `Updated: <list of files rewritten>. Memory is current.`

## If Scope Is Large

If `git diff` spans many components, offer:
`"Many areas changed. Run full /explore instead? [Y/N]"`
