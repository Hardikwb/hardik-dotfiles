---
name: plan
description: Plan a feature, refactor, or engineering task. User invokes with /plan <description>. Reads .ai/project-memory if it exists, asks minimal clarifying questions, writes PLAN.md to repo root.
---

# Plan

## On Start

Check `.ai/project-memory/` exists.

- **Missing** → ask: *"No project memory found. Run /explore first? [Y/N]"*
  - Y → run `explore` skill, then resume here.
  - N → continue; expect more questions during requirements.
- **Exists** → load selectively (do not read all files):
  - Always: `overview.md`, `architecture.md`
  - Feature touches data/APIs: also `flows.md`
  - Feature names a component: also `components/<name>.md` only
  - Check `meta.md` last_updated vs recent commits — warn if stale.

---

## Research

*Only when memory doesn't cover the feature area.*

Spawn independent read-only agents → `references/harness-adapters.md`

| Agent | Reads | Returns |
|-------|-------|---------|
| Structure | Package manifest, top-level dirs | Stack, entry points |
| Domain | 3–5 files nearest feature | Patterns, models, conventions |
| Contracts | Routes, interfaces, schema near feature | API shape, auth, data flow |

Each returns: findings · implications · unknowns (bullets only).
Parent synthesizes. Sub-agents never edit source files.

---

## Requirements

Load `references/question-bank.md`. Ask only what changes the plan.
One question at a time. Use `verify-requirements` skill format.

---

## Plan Output

Write `PLAN.md` to repo root → `references/plan-template.md`

Sections (omit irrelevant):
- Goal + non-goals
- Findings (with file refs from memory)
- Requirements + acceptance criteria
- Design + **vertical slices** *(each = working end-to-end increment)*
- Files likely to change
- Test strategy *(reference test folder paths from memory — do not read tests)*
- Risks + implementation handoff

End with: `PLAN.md written. Ready to start Slice 1?`

---

## Pruning

- Don't read test files — note path from memory only.
- Don't read files memory already covers.
- Don't ask what memory already answers.
- Don't spawn agents if memory covers the feature area.
- Don't offer multiple designs — one recommended + why.
