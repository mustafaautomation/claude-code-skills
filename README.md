# Claude Code Skills

[![Validate](https://github.com/mustafaautomation/claude-code-skills/actions/workflows/validate.yml/badge.svg)](https://github.com/mustafaautomation/claude-code-skills/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Skills-FF6B35.svg)](https://docs.anthropic.com/en/docs/claude-code)

Collection of custom Claude Code skills for enterprise development teams. Drop-in skills that give Claude Code superpowers for code review, test generation, documentation, migrations, and more.

---

## Skills

| Skill | Command | What It Does |
|-------|---------|-------------|
| **PR Reviewer** | `/pr-reviewer` | Review branch changes for bugs, security, performance |
| **Test Generator** | `/test-generator` | Generate tests for changed files (Vitest/Jest/JUnit/NUnit/pytest) |
| **Doc Writer** | `/doc-writer` | Generate API docs from source code (OpenAPI/Markdown) |
| **Migration Assistant** | `/migration-assistant` | Migrate between frameworks (JS→TS, Jest→Vitest, CJS→ESM, etc.) |
| **Dependency Auditor** | `/dependency-auditor` | Audit deps for CVEs, outdated packages, license issues |
| **DB Query Helper** | `/db-query-helper` | Write, optimize, and explain SQL from your schema |

---

## Quick Install

```bash
git clone https://github.com/mustafaautomation/claude-code-skills.git
ln -s $(pwd)/claude-code-skills/skills ~/.claude/skills
```

Or copy individual skills:
```bash
cp -r claude-code-skills/skills/pr-reviewer ~/.claude/skills/
```

See [INSTALL.md](INSTALL.md) for all options.

---

## Skill Highlights

### PR Reviewer
```
/pr-reviewer
```
Analyzes `git diff main...HEAD` and reports:
- **Critical**: SQL injection, XSS, hardcoded secrets
- **High**: Logic errors, race conditions, missing error handling
- **Medium**: N+1 queries, dead code, naming issues
- Every finding includes a fix suggestion with code

### Test Generator
```
/test-generator
```
Auto-detects your test framework and generates:
- Happy path, edge cases, error cases
- Mocks for external dependencies
- Follows your project's existing test patterns

### Migration Assistant
```
/migration-assistant
```
Supported migrations:
- JavaScript → TypeScript
- Jest → Vitest
- CommonJS → ESM
- Webpack → Vite
- React Class → Hooks
- Express 4 → 5
- And more...

### DB Query Helper
```
/db-query-helper
```
Reads your schema (Prisma, Drizzle, TypeORM, Django, Rails) and helps:
- Write queries from natural language
- Optimize slow queries with index suggestions
- Explain complex queries in plain English

---

## Project Structure

```
claude-code-skills/
├── skills/
│   ├── pr-reviewer/
│   │   └── skill.md              # Code review with severity + fix suggestions
│   ├── test-generator/
│   │   └── skill.md              # Multi-framework test generation
│   ├── doc-writer/
│   │   └── skill.md              # API documentation (OpenAPI/Markdown)
│   ├── migration-assistant/
│   │   └── skill.md              # Framework/language migration helper
│   ├── dependency-auditor/
│   │   └── skill.md              # Security audit + license check
│   └── db-query-helper/
│       └── skill.md              # SQL write/optimize/explain
├── INSTALL.md                     # Installation guide
└── .github/workflows/validate.yml # CI: validates all skill files
```

---

## Why Custom Skills?

| Without Skills | With Skills |
|----------------|-------------|
| Ask Claude to "review my code" every time | `/pr-reviewer` — consistent, thorough review |
| Explain what test framework you use | `/test-generator` — auto-detects and follows patterns |
| Manually write OpenAPI YAML | `/doc-writer` — generates from actual code |
| Google "how to migrate from X to Y" | `/migration-assistant` — step-by-step with verification |

Skills encode **organizational knowledge** so every developer on the team gets the same quality AI assistance.

---

## License

MIT

---

Built by [Quvantic](https://quvantic.com)
