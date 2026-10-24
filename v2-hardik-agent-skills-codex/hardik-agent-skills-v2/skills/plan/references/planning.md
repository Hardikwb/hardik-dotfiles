# Planning rules

## Flow

User intent → memory retrieval → targeted exploration → unresolved questions → architecture → scale shape → implementation decomposition → confirmation.

## Retrieval priority

1. User-provided context
2. Project memory
3. Relevant source files
4. Subagents for parallel gaps
5. User questions for decisions nobody else can answer

Never ask the user for facts already present in memory or code.

## Architecture-first output

For complex work, summarize:
- goal and boundaries
- major components
- ownership of state/data
- control-flow and data-flow
- contracts/integration points
- scale shape: users, traffic, storage, latency, async/background work
- important failure boundaries

Then turn the architecture into implementation plans.

## Plan quality

Every plan should make clear:
- what changes
- where it changes
- dependencies/order
- how success is verified
- what is explicitly out of scope
- unresolved decisions

Prefer references to files/components over long copied descriptions.
