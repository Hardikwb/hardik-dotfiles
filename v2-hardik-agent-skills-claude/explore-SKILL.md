---
name: explore
description: Map the codebase and write structured project memory to .ai/project-memory/. Triggered by /explore or auto-triggered when /plan finds no memory. Run once per project, then use /update-memory after significant changes. Never edits source files.
---

# Explore

Writes `.ai/project-memory/`. Read-only on source. Never modifies the working tree.

## Memory Layout

```
.ai/project-memory/
├── overview.md       ← stack, entry points, conventions
├── architecture.md   ← module map, patterns, constraints
├── flows.md          ← 2–3 key control/data flows
├── components/       ← one .md per component
└── meta.md           ← timestamp, git ref, explored list
```

File formats → `references/memory-schema.md`

---

## Agents

Spawn in parallel → `references/memory-schema.md` for output format,
`../plan/references/harness-adapters.md` for how to spawn.

| Agent | Reads | Writes |
|-------|-------|--------|
| Overview | README, manifests, entry points | `overview.md` |
| Architecture | Module dirs, imports, interfaces | `architecture.md` |
| Flow | Trace 2–3 key request/data paths | `flows.md` |
| Components | All top-level modules/services | `components/<name>.md` each |

**Component granularity**: agent decides — service, top-level dir, or major module.
**Tests**: note folder path + file count only. Do not read test contents.

---

## Component File Format

```
# <Component Name>
Purpose: <one sentence>
Key files: <path> → <role>
Patterns: <list>
External deps: <list>
Tests: <folder/> (<N> files)
Constraints: <list>
```

---

## Finish

Write `meta.md`:
```
last_updated: <ISO timestamp>
git_commit: <short hash>
explored: [<component names>]
```

Print: `Memory written to .ai/project-memory/. Run /plan to continue.`
