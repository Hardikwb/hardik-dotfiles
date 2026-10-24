# Planning Question Bank

Use this as a lookup table, not a script.

## Scope

Ask:
- Is this behavior replacing existing behavior, adding a new path, or fixing an edge case?
- What is explicitly out of scope?

## UX / interaction

Ask:
- Who initiates the flow?
- What should happen on success?
- What should happen on cancellation?
- What should the user see while work is in progress?

## Architecture

Ask:
- Does an existing component already own this responsibility?
- Must the new behavior be synchronous, asynchronous, event-driven, or streaming?
- Is there a compatibility requirement?

## Data

Ask:
- Is the data durable?
- Is the source of truth already defined?
- Do we need migration/backfill?
- What happens on partial failure?

## Concurrency / reliability

Ask:
- Can the same operation run twice?
- Does ordering matter?
- What is the recovery path after a worker/process crash?
- Is idempotency required?

## Security

Ask:
- Who may perform the action?
- Are there trust-boundary changes?
- What inputs are untrusted?
- Are secrets or sensitive data involved?

## Evaluation

Ask:
- What observable behavior proves the change is correct?
- What existing tests cover it?
- What negative cases should remain silent/rejected?
- What production trace or metric would expose a regression?

## Migration / rollout

Ask:
- Can old and new behavior coexist?
- Is a flag, staged rollout, or backfill needed?
- How will rollback work?

## Question suppression

Do not ask a question when:
- the repository already establishes the answer,
- the answer has no effect on the plan,
- the user has explicitly stated the answer,
- the decision is a low-impact implementation detail the agent can safely choose.
