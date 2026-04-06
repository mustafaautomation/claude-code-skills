# CI Failure Analyzer

Analyze failing CI pipelines, identify root causes, and suggest fixes — without manual log reading.

## Process

1. Get the failing workflow run: `gh run list --limit 1 --json databaseId,conclusion --jq '.[0]'`
2. Fetch the failure logs: `gh run view <id> --log-failed`
3. Analyze the logs to classify the failure:

### Failure Categories

| Category | Pattern | Example |
|----------|---------|---------|
| **Test failure** | `FAIL`, `AssertionError`, `Expected X got Y` | Broken assertion, flaky test |
| **Build failure** | `tsc`, `error TS`, `Cannot find module` | Type error, missing import |
| **Lint failure** | `eslint`, `prettier`, `no-unused-vars` | Code style violation |
| **Dependency** | `npm ERR!`, `ERESOLVE`, `peer dep` | Package conflict, missing lock file |
| **Timeout** | `exceeded`, `timed out`, `SIGTERM` | Slow test, resource exhaustion |
| **Infrastructure** | `rate limit`, `ECONNREFUSED`, `disk full` | GitHub/npm outage, runner issue |
| **Permission** | `403`, `EACCES`, `permission denied` | Missing secret, wrong token scope |

4. For each failure, provide:
   - Root cause classification
   - The exact error with file/line
   - Step-by-step fix instructions
   - Whether it's safe to re-run (infra) vs needs code change (bug)

## Output Format

```markdown
## CI Failure Analysis

### Workflow: [name] — Run #[id]
**Status**: Failed at step "[step name]"
**Category**: [Test failure / Build failure / ...]

### Root Cause
[Clear 1-2 sentence explanation]

### Error
```
[exact error from logs]
```

### Fix
1. [Step 1]
2. [Step 2]

### Recommendation
- [ ] Re-run (if infra/transient)
- [ ] Fix code (if test/build/lint)
- [ ] Update dependencies (if dep conflict)
```

## Best Practices

- Always check if the failure is new (this PR) or pre-existing (flaky on main)
- For test failures, check if the test is in the flaky test quarantine list
- For dependency failures, try `npm ci` with a clean cache before debugging
- For timeout failures, check if the runner specs match production needs
- Include the `gh run view --log-failed` command so the user can dig deeper
