# Question Bank

Lookup table — not a script. Pick only categories relevant to the feature.

## Scope
- Replacing existing behavior, adding a new path, or fixing an edge case?
- What is explicitly out of scope this iteration?

## User-visible behavior
- Who initiates the flow?
- What happens on success / failure / cancellation?
- What does the user see during progress?

## Architecture
- Does an existing component already own this responsibility?
- Sync, async, event-driven, or streaming?
- Any compatibility requirement with existing contracts?

## Data + state
- Is data durable? Source of truth already defined?
- Migration or backfill needed?
- What happens on partial failure?

## Concurrency + reliability
- Can the operation run twice (idempotency required)?
- Does ordering matter?
- Recovery path after crash or timeout?

## Security
- Who may perform this action (auth / roles)?
- Trust boundary changes?
- Secrets or sensitive data in scope?

## Acceptance
- What observable behavior proves the change is correct?
- What existing tests cover adjacent behavior?
- What negative cases must be silent or rejected?

## Rollout
- Can old and new behavior coexist (flag, staged rollout)?
- Rollback strategy?
- Backfill needed?

---

## Suppression Rules

Never ask when:
- Memory or codebase already establishes the answer
- The answer has no effect on architecture or acceptance criteria
- The user already stated it
- It's a low-impact detail the agent can safely choose (e.g. variable name, file location within a module)
