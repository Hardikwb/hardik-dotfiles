# Usage

## Planning

Use the plan skill as the user-facing entry point:

```text
/plan <task>
```

Examples:

```text
/plan Add Redis caching to the chat service
/plan Build the first version of the SaaS
```

You do not need to mention Lavish. Planning stays textual unless a visual plan is requested.

When you want the visual surface, explicitly request it, for example:

```text
/plan Build the SaaS and show me the architecture visually
```

or use the installed visualization/Lavish skill directly.

## Memory

The normal planner retrieves memory automatically. Do not manually load every memory file into context.

When memory needs to change, the agent should propose a small update and ask for approval.
