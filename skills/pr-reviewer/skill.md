# AI PR Reviewer

Review the current branch's changes against the base branch with enterprise-grade analysis.

## Process

1. Run `git diff main...HEAD` to get all changes in this branch
2. Analyze each changed file for:
   - **Bugs**: Logic errors, null pointer risks, race conditions, off-by-one errors
   - **Security**: SQL injection, XSS, hardcoded secrets, unsafe deserialization
   - **Performance**: N+1 queries, unnecessary allocations, missing indexes
   - **Code quality**: Dead code, duplicated logic, naming issues, missing error handling
   - **Testing**: Untested paths, missing edge cases, brittle assertions
3. For each finding, provide:
   - Severity (critical/high/medium/low)
   - File and line number
   - What's wrong
   - How to fix it (with code suggestion when possible)
4. Summarize: total findings by severity, overall assessment (approve/request changes)

## Output Format

```markdown
## PR Review: [branch name]

### Summary
- X critical, Y high, Z medium findings
- Overall: [APPROVE / REQUEST CHANGES]

### Findings

#### [CRITICAL] file.ts:42 — SQL injection risk
**Issue:** User input concatenated directly into query string
**Fix:**
\`\`\`typescript
// Before
const query = `SELECT * FROM users WHERE id = ${userId}`;
// After
const query = 'SELECT * FROM users WHERE id = $1';
const result = await db.query(query, [userId]);
\`\`\`
```

## Key Rules
- Only flag real issues — no style nitpicks unless they cause bugs
- Every finding must include a fix suggestion
- Be specific about file:line — vague comments are useless
- If the code looks good, say so — don't manufacture issues
