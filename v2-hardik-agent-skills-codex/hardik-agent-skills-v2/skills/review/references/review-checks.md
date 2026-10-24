# Review checks

Priority order:

1. requirement/plan mismatch
2. correctness and data integrity
3. broken contracts/integration
4. security/auth boundary changes
5. error/retry/idempotency behavior
6. performance/concurrency risks
7. tests for the changed behavior
8. style/convention issues

Use focused evidence. Prefer the smallest relevant test set over broad test-file ingestion.
