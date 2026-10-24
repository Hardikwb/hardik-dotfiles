# Memory invalidation and update

After code changes, determine which memory entries reference or describe affected areas.

For each affected entry:
- mark what is stale
- identify the new source paths
- propose the smallest update

Do not rewrite unrelated memory.

Example:

```text
Changed: src/services/chat-cache.ts
Likely affected:
- architecture.md
- flows/data-flow.md
- components/cache.md
Not affected:
- database.md
- auth.md
```

Ask before persisting the changes.
