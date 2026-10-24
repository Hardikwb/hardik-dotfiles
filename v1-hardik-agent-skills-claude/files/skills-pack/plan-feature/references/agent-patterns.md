# Agent Communication Patterns

Reference for the plan-feature skill. Load when planning multi-agent coordination.

---

## 1 · Delegation (Most Common)

Main agent spawns N domain sub-agents. Each gets one focused task.
Main agent waits, collects all outputs, merges into a single result.

```
Main Agent
  ├─► Sub-agent A: "Read data layer. Return: models, schema, patterns."
  ├─► Sub-agent B: "Read API layer. Return: routes, auth, contracts."
  └─► Sub-agent C: "Read UI layer. Return: components, state, hooks."
  
Main Agent ◄── Merges all three outputs into CONTEXT BLOCK
```

**Use when**: Exploring an unfamiliar codebase, gathering context across many files in parallel.  
**Pitfall**: Don't spawn too many — 3–4 agents is optimal. More than 5 adds coordination overhead.

---

## 2 · Creator-Verifier

One sub-agent builds a component. A second reviews it independently before the main agent accepts it.

```
Main Agent
  ├─► Creator: "Implement the UserService.createUser() method."
  └─► Verifier: "Review Creator's output. Check: types correct? 
                 Edge cases handled? Follows repo conventions? 
                 Return: PASS or list of issues."
  
If issues → Creator fixes → Verifier re-checks (max 2 cycles)
Main Agent accepts when Verifier returns PASS
```

**Use when**: High-stakes code (auth, payments, data migrations), or when the milestone is complex enough that bugs are likely.  
**Pitfall**: Verifier must read the same codebase context as Creator — pass the CONTEXT BLOCK to both.

---

## 3 · Orchestrator

A dedicated orchestrator agent monitors all spawned sub-agents, handles timeouts, and merges work.

```
Main Agent
  └─► Orchestrator Agent
        ├─► Sub-agent A (feature slice 1)
        ├─► Sub-agent B (feature slice 2)
        └─► Sub-agent C (feature slice 3)
        
Orchestrator tracks status, retries failures, resolves merge conflicts.
Returns final merged result to Main Agent.
```

**Use when**: 5+ parallel sub-agents, or when sub-agents may conflict on shared files.  
**Pitfall**: Orchestrator itself is a sub-agent — keep its instructions simple and its job mechanical (track, collect, merge only).

---

## 4 · Negotiation

Multiple agents work on the same shared resource (same file, same schema) and must coordinate.

```
Agent A wants to modify: users table (add column)
Agent B wants to modify: users table (rename column)

Negotiation protocol:
  1. Each agent declares its intended change
  2. Conflict detected by orchestrator
  3. One agent is designated "owner" for that resource
  4. Other agents describe their need → owner implements it
```

**Use when**: Microservices touching a shared DB, or concurrent feature branches modifying the same file.  
**Pitfall**: Rare in single-session planning. Prefer sequential milestones over concurrent agents on shared resources.

---

## Milestone Validators

Run after each milestone completes.

### Scrutiny Validator
Automated checks on the completed milestone:
- `typecheck` (tsc --noEmit, mypy, go vet)
- `lint` (eslint, ruff, golangci-lint)
- `unit tests` for the new code only
- `integration smoke test` for the feature slice

Spawn a Creator-Verifier pair if tests fail: Creator fixes, Verifier confirms fix doesn't break other tests.

### User-Testing Validator
Human-simulated QA check (use computer-use or manual):
- Launch the application
- Navigate to the feature
- Attempt the happy path
- Attempt 2–3 edge cases
- Report what's broken vs what works

**Only needed for UI-facing milestones or API endpoints with complex user flows.**
