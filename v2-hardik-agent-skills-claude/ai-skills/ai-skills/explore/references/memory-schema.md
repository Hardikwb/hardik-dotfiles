# Memory Schema

Exact formats for `.ai/project-memory/` files.
Read by: `explore`, `update-memory`, and `plan` (selective load).

---

## overview.md

```
# Overview

Stack: <languages · frameworks · key libs>
Entry points: <main files>
Purpose: <what this project does — 2 sentences max>

## Directory Layout
<path/> — <purpose>
...

## Conventions
Naming: ...
File structure: ...
Import style: ...
Error handling: ...
```

---

## architecture.md

```
# Architecture

## Module Map
<module or service> — <responsibility>
...

## Key Patterns
<pattern> — <where used>
...

## Critical Constraints
- <do not break X because Y>
...

## External Dependencies
<service/API> — <used by> — <how called>
```

---

## flows.md

```
# Flows

## Flow 1: <name e.g. "HTTP Request → DB → Response">
Step 1: <what happens> — `path/file`
Step 2: <what happens> — `path/file`
...

## Flow 2: <name e.g. "Background Job">
...
```

Keep flows to 2–3 most important paths. Add more only if a feature requires it.

---

## components/<name>.md

```
# <Component Name>

Purpose: <one sentence>

Key files:
  path/file → role
  path/file → role

Patterns: <list>
External deps: <list>
Tests: tests/<folder>/ (<N> files)
Constraints: <list>
```

One file per component. Agent decides granularity at explore time.

---

## meta.md

```
last_updated: <ISO 8601>
git_commit: <short hash>
explored:
  - <component name>
  - ...
notes: <anything unusual e.g. monorepo, generated code areas, no tests>
```

`plan` reads `meta.md` to detect staleness. `update-memory` reads it to diff since last run.
