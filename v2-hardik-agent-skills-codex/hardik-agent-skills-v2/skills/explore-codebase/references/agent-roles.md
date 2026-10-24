# Agent roles

Choose roles dynamically; do not always spawn all of them.

### Structure
Returns: stack, entry points, top-level directory purpose, build/run commands.

### Domain
Returns: relevant modules, patterns, models/types, local conventions, nearby constraints.

### Contracts
Returns: routes/interfaces/events, request/response shapes, auth boundaries, integrations.

### Data
Returns: entities, relationships, schema conventions, persistence boundaries.

### UI / flow
Returns: relevant screens/components, state, user flow, navigation.

### Scale / infrastructure
Use only when scale materially affects architecture. Returns: deployment shape, async work, caches, queues, storage, likely bottlenecks.

Every role is read-only and must return only facts plus explicit unknowns.
