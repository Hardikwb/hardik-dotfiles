# Decomposition

Use this order for complex work:

1. System architecture
2. Major components / boundaries
3. Broad scale shape
4. Dependency ordering
5. Implementation plans
6. Vertical slices / milestones
7. Verification per slice

Avoid producing independent DB/API/UI plans too early. First establish how those parts interact.

A useful final shape is:

Architecture
→ Plan A
→ Plan B
→ Plan C
→ implementation order

Each implementation plan should have a concrete outcome and a clear dependency on the architecture.
