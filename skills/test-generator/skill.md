# AI Test Generator

Generate comprehensive tests for code changes in the current branch.

## Process

1. Run `git diff main...HEAD --name-only` to identify changed files
2. For each changed source file (not test files):
   - Read the file to understand its functions/classes/exports
   - Identify the testing framework from `package.json`, `pom.xml`, or `*.csproj`
   - Generate test cases covering:
     - **Happy path** — normal expected behavior
     - **Edge cases** — empty inputs, boundaries, null/undefined
     - **Error cases** — invalid inputs, network failures, permission errors
     - **Integration points** — mocks for external dependencies
3. Write test files following the project's existing test patterns
4. Run the tests to verify they pass

## Framework Detection

| File | Framework | Test Location |
|------|-----------|---------------|
| `package.json` with vitest | Vitest | `tests/` or `__tests__/` |
| `package.json` with jest | Jest | `__tests__/` or `*.test.ts` |
| `pom.xml` | JUnit 5 / TestNG | `src/test/java/` |
| `*.csproj` with NUnit | NUnit | `Tests/` |
| `requirements.txt` with pytest | pytest | `tests/` |

## Rules
- Follow the project's existing test patterns (file naming, assertion style, setup/teardown)
- Use the project's existing test utilities and helpers
- Mock external services — never make real API calls in unit tests
- Each test should have a descriptive name that explains what it verifies
- Aim for one assertion per test when possible
