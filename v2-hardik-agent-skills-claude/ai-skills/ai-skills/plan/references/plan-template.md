# Plan: <title>

## Goal
<What outcome are we achieving — one or two sentences.>

## Non-goals
- <explicit deferral>

---

## Findings
- <fact> — `path/to/evidence`

---

## Requirements

**Must**
- ...

**Won't (this iteration)**
- ...

**Acceptance criteria**
- ...

---

## Design

<Architecture note. Prefer existing patterns over new abstractions. One recommendation — not multiple options.>

### Vertical Slices

**Slice 1 — <name>**
Change: ...
Files: `path/file` — what changes
Deps on: <prior slice or external>
Verified by: <concrete check>

**Slice 2 — <name>**
...

---

## Files Likely to Change
- `path/file` — reason

---

## Test Strategy
- Unit: ...
- Integration: ...
- Negative cases: ...
- Test folder: `<path from memory>` (do not reread during implementation)

---

## Risks
| Risk | Detection | Mitigation |
|------|-----------|------------|
| ... | ... | ... |

---

## Implementation Handoff

Start with: Slice 1
Guardrails: ...
Do not change: ...
Open decisions: <none or list>
