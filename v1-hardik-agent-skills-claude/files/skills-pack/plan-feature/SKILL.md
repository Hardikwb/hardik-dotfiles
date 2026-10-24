---
name: plan-feature
description: >
  Orchestrate a complete implementation plan before writing any code. Use this skill
  whenever the user says "plan", "design this", "let's build", "I want to implement",
  "how should we approach", "architect", "what's the best way to build", or describes
  a non-trivial feature, system change, or new module to create. Also trigger when
  the user pastes a requirement doc, user story, or ticket and doesn't yet have a plan.
  DO NOT trigger for simple bug fixes, single-file edits, config changes, or when the
  user explicitly asks to just "start coding" without planning.
---

# Feature Planning Orchestrator

You are in **PLAN MODE**. Think before building.  
No production code. No file edits. Return a confirmed, milestone-based plan only.

## Steering

**Vertical Slicing** — Each milestone delivers one thin, working end-to-end slice. Never layer-by-layer (all DB → all API → all UI). Instead: one feature works fully, then expand.  
**Leading Words** — Use dense phrases that compress intent: "Schema-first", "Contract-before-implement", "Mock-at-boundary", "Fail-fast". These anchor the agent to the right execution pattern.  
**Questions before commitment** — Ambiguous requirements cost more to fix than asking once. Ask early, ask precisely, then stop and wait.

---

## Steps

### 1 · Explore the Codebase

Spawn parallel read agents — one per domain. Each agent gets a single focused job.
Merge their outputs into one **CONTEXT BLOCK** before moving to Step 2.

**Structure Agent**
```
Task: Read top-level directory, package manifest (package.json / go.mod / pyproject.toml), 
      any README or ARCHITECTURE docs.
Return (bullets only):
  - Tech stack and major frameworks
  - Entry points (main files, server start, CLI root)
  - Directory layout and purpose of each top-level folder
  - Monorepo structure if applicable
```

**Domain Agent**
```
Task: Locate files closest to [FEATURE_AREA]. Read the 3–5 most relevant ones.
Return (bullets only):
  - Existing patterns and conventions in this area
  - Data models or types relevant to the feature
  - Naming conventions used
  - Any TODO / FIXME / HACK comments near this area
```

**Contracts Agent**
```
Task: Find API routes, service interfaces, or DB schema related to [FEATURE_AREA].
Return (bullets only):
  - API shape (method, path, request/response types)
  - Data flow (who calls what, in what order)
  - Auth patterns (middleware, guards, decorators)
  - External dependencies or third-party services involved
```

Compiled **CONTEXT BLOCK** format:
```
Stack: [e.g. Node 20, Express, Prisma, PostgreSQL]
Entry: [e.g. src/index.ts, src/app.ts]
Key files:
  - path/to/file.ts → purpose
  - path/to/model.ts → purpose
Patterns: [e.g. repository pattern, dependency injection, functional components]
Conventions: [e.g. snake_case DB, camelCase TS, barrel exports]
Constraints: [e.g. no breaking schema changes, must be backwards compatible]
Hotspots: [files most features touch]
```

---

### 2 · Ask Clarifying Questions

**STOP. Ask before planning.** Present at most 5 numbered questions.
Pick only the unknowns that would materially change the design. Ignore the rest.

Question categories to draw from:
- **Scope** — What's explicitly in and out of scope for this iteration?
- **Error handling** — What should happen when X fails? User-facing error or silent?
- **Auth/Permissions** — Who can access this? Any role-based rules?
- **Data** — Volume? Retention policy? Consistency requirements (eventual vs strong)?
- **Interface** — REST API, internal service call, or UI-facing? Contract already exists?
- **Rollout** — Feature flag? Gradual rollout? Breaking change?

Output format:
```
Before I design the plan, a few things would change the approach:

1. [Scope] ...?
2. [Error handling] ...?
3. [Auth] ...?
...

Answer what you know — I'll assume sensible defaults for anything you skip.
```

**Wait for the user's reply before proceeding to Step 3.**

---

### 3 · Build the Implementation Plan

After receiving answers (or user says "skip", "defaults are fine", "just plan it"):

```markdown
## Plan: [Feature Name]

### Context Summary
- Stack: [from exploration]
- Affected areas: [modules / files]
- Key constraint: [the most important constraint]
- Assumptions: [defaults taken where user didn't answer]

---

### Milestones

**M1 — [Milestone Name]** · [S / M / L]
Goal: [What is demonstrably working and testable after this milestone — one sentence]
Files:
  - path/to/file.ts [create / modify] — what changes
  - path/to/other.ts [create / modify] — what changes
Done when: [Concrete check: "POST /api/x returns 201", "unit test passes", etc.]

**M2 — [Milestone Name]** · [S / M / L]
Goal: ...
Files: ...
Done when: ...

[Continue for remaining milestones]

---

### Milestone Order Rationale
[One sentence: why this order — e.g. "Schema locked first so API contract is stable"]

### Out of Scope (this iteration)
- [Explicit exclusion 1]
- [Explicit exclusion 2]

### Open Questions
- [Anything still unresolved that could affect implementation]
```

---

### 4 · Confirm Before Starting

End with exactly this line — nothing after it:

```
Start with M1? Or adjust the plan first?
```

Do not write any code, create any files, or proceed until the user confirms.

---

## Reference

### Default Milestone Order
When in doubt, follow this sequence:
`Schema / Migration → Repository / Service layer → API Handler → Unit Tests → Integration Tests → UI → Docs`

Each milestone should produce one vertical slice that works end-to-end.

### Validation per Milestone (Scrutiny Validator)
After each milestone, run: `typecheck → lint → unit test for that slice → smoke test`  
Spawn a Creator-Verifier pair if the milestone is complex: one agent writes, one reviews.

### Agent Communication Patterns
See `references/agent-patterns.md` for full details on:
- **Delegation** — Main agent spawns N domain agents, collects structured output, merges
- **Creator-Verifier** — One sub-agent builds, a second reviews before merge
- **Orchestrator** — Dedicated tracker monitors all sub-agents and handles failures
- **Negotiation** — Multiple agents resolve conflicts on shared resources

### Leading Word Bank
Use these as anchors in plans and milestone descriptions:
`Schema-first` · `Contract-before-implement` · `Mock-at-boundary` · `Inject-don't-import` · `Fail-fast` · `Validate-at-edge` · `Vertical-slice` · `Single-responsibility` · `Idempotent` · `Backwards-compatible`

### When to Skip Codebase Exploration (Step 1)
- User explicitly describes the relevant files and structure already
- Codebase context was already gathered in this session (reference that CONTEXT BLOCK)
- Greenfield project with no existing code
