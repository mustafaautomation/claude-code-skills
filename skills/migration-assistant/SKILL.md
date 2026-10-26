---
name: migration-assistant
description: Plans and carries out incremental code migrations such as JavaScript to TypeScript, Jest to Vitest, CommonJS to ESM or Webpack to Vite, running tests after each step. Use when the user wants to migrate a framework, language or major version.
---

# Migration Assistant

Help migrate codebases between frameworks, languages, or major versions.

## Supported Migrations

| From | To | What Changes |
|------|----|-------------|
| JavaScript | TypeScript | Add types, tsconfig, update imports |
| Express 4 | Express 5 | Router changes, middleware updates |
| Jest | Vitest | Config, imports, assertion style |
| Mocha/Chai | Vitest | Complete test rewrite |
| React Class | React Hooks | State, lifecycle, refs |
| Vue 2 | Vue 3 | Composition API, reactivity |
| Webpack | Vite | Config, plugins, dev server |
| CommonJS | ESM | require→import, package.json type |
| Node 16 | Node 20 | Deprecated APIs, new features |

## Process

1. Identify current stack from config files (`package.json`, `tsconfig.json`, etc.)
2. Ask user what they want to migrate to
3. Create a migration plan with files affected and changes needed
4. Execute migration file by file:
   - Update config files first (tsconfig, package.json, vite.config)
   - Migrate source files (update imports, syntax, patterns)
   - Migrate test files
   - Update CI/CD configs
5. Run linter and tests after each batch
6. Fix any issues found

## Rules
- Never migrate everything at once — do it incrementally
- Run tests after each file migration to catch issues early
- Preserve git history — don't delete and recreate files
- Keep both old and new patterns working during transition when possible
- Document any manual steps needed (e.g., "update your IDE TypeScript version")

## Output

1. **Migration plan**: a list of affected files and the change needed in each, before any edits
2. **Progress log**: after each batch, the files migrated and the lint/test result
3. **Manual steps**: anything the user must do themselves
4. **Summary**: what changed, what still uses the old pattern, and how to roll back
