# Claude Code Skills

[![Validate](https://github.com/mustafaautomation/claude-code-skills/actions/workflows/validate.yml/badge.svg)](https://github.com/mustafaautomation/claude-code-skills/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Skills-FF6B35.svg)](https://docs.anthropic.com/en/docs/claude-code)

Collection of custom Claude Code skills for code review, test generation, documentation, migrations, dependency audits and SQL help. Each skill is a directory under `skills/` containing a `SKILL.md` file in the [Claude Code skill format](https://code.claude.com/docs/en/skills): YAML frontmatter with `name` and `description`, followed by Markdown instructions. Claude Code can load a skill automatically when the request matches its description, or you can run it with `/skill-name`.

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
| **API Contract Checker** | `/api-contract-checker` | Compare API routes in code with the OpenAPI/Swagger spec |
| **CI Failure Analyzer** | `/ci-failure-analyzer` | Read failing GitHub Actions logs and suggest the likely cause and fix |

---

## Quick Install

Personal skills live in `~/.claude/skills/<skill-name>/SKILL.md` and project skills in `.claude/skills/<skill-name>/SKILL.md`.

```bash
git clone https://github.com/mustafaautomation/claude-code-skills.git

# All skills, for every project (copies the skill folders)
mkdir -p ~/.claude/skills
cp -r claude-code-skills/skills/* ~/.claude/skills/

# Or one skill, for a single repository
mkdir -p .claude/skills
cp -r claude-code-skills/skills/pr-reviewer .claude/skills/
```

Then start `claude` and type `/pr-reviewer` (or ask for a review and let Claude pick the skill). See [INSTALL.md](INSTALL.md) for symlinking instead of copying.

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
│   │   └── SKILL.md              # Code review with severity + fix suggestions
│   ├── test-generator/
│   │   └── SKILL.md              # Multi-framework test generation
│   ├── doc-writer/
│   │   └── SKILL.md              # API documentation (OpenAPI/Markdown)
│   ├── migration-assistant/
│   │   └── SKILL.md              # Framework/language migration helper
│   ├── dependency-auditor/
│   │   └── SKILL.md              # Security audit + license check
│   ├── db-query-helper/
│   │   └── SKILL.md              # SQL write/optimize/explain
│   ├── api-contract-checker/
│   │   └── SKILL.md              # Code routes vs OpenAPI/Swagger spec
│   └── ci-failure-analyzer/
│       └── SKILL.md              # Failing GitHub Actions log analysis
├── scripts/validate.sh            # Format checks run by CI (fails on any error)
├── INSTALL.md                     # Installation guide
└── .github/workflows/validate.yml # CI: runs scripts/validate.sh
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

## Validation

CI runs `scripts/validate.sh` on every push and pull request. The build fails if any skill:
- has no `SKILL.md` (a lowercase `skill.md` is rejected)
- doesn't start with YAML frontmatter, or the frontmatter isn't closed
- is missing `name` or `description`, or its `name` isn't lowercase-hyphenated or doesn't match the folder name
- is missing a `# Title`, a `## Process` section or a `## Output` section, or has a body under 200 characters

Run it locally with `bash scripts/validate.sh` (or `bash scripts/validate.sh path/to/skills`). It checks format only; it does not test how the skills behave in Claude Code.

---

## License

MIT

---

Built by [Quvantic](https://quvantic.com)
