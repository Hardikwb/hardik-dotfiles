# Agent delegation

Use delegation only when the task contains independent context gaps.

Good planning agents:
- architecture reconnaissance
- data/schema analysis
- API/contracts analysis
- frontend/user-flow analysis
- scale/infrastructure analysis

Give each agent one narrow question and a structured return shape.

Example:

```yaml
area: data
files:
  - src/models/user.ts
findings:
  - ...
flows:
  - ...
constraints:
  - ...
unknowns:
  - ...
confidence: high
```

The main agent merges outputs and resolves conflicts. Agents do not decide product requirements for the user.

Avoid more than 4 agents for ordinary planning unless the repository or problem genuinely requires it.
