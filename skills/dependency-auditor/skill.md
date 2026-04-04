# Dependency Auditor

Audit project dependencies for security vulnerabilities, outdated packages, and license compliance.

## Process

1. Detect package manager: npm, yarn, pnpm, pip, maven, nuget, cargo
2. Run the appropriate audit command:
   - `npm audit --json`
   - `pip-audit --format=json`
   - `mvn dependency:tree`
   - `dotnet list package --vulnerable`
   - `cargo audit --json`
3. Analyze results and categorize:
   - **Critical/High CVEs** — Must fix immediately
   - **Outdated packages** — More than 2 major versions behind
   - **Deprecated packages** — No longer maintained
   - **License issues** — GPL in a commercial project, etc.
4. For each issue, provide:
   - Package name and current version
   - Severity and CVE ID
   - Fixed version (if available)
   - Migration command
5. Generate a prioritized fix plan

## Output

```markdown
## Dependency Audit Report

### Critical (fix now)
| Package | Current | Fixed | CVE | Risk |
|---------|---------|-------|-----|------|
| lodash | 4.17.19 | 4.17.21 | CVE-2021-23337 | Prototype pollution |

**Fix:** `npm install lodash@4.17.21`

### Outdated (plan upgrade)
| Package | Current | Latest | Behind |
|---------|---------|--------|--------|
| react | 17.0.2 | 19.1.0 | 2 majors |

### License Warnings
| Package | License | Risk |
|---------|---------|------|
| gpl-dep | GPL-3.0 | Copyleft — may require open-sourcing your code |
```

## Rules
- Focus on actionable items — skip informational/low findings
- Provide exact commands to fix each issue
- Flag breaking changes in major version upgrades
- Check if vulnerable versions are actually used (not just installed)
