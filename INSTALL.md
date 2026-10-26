# Installation

Claude Code loads skills from `<skills-dir>/<skill-name>/SKILL.md`:
- Personal (all projects): `~/.claude/skills/`
- Project (one repository, can be committed): `.claude/skills/`

## Option 1: Copy all skills

```bash
git clone https://github.com/mustafaautomation/claude-code-skills.git
mkdir -p ~/.claude/skills
cp -r claude-code-skills/skills/* ~/.claude/skills/
```

## Option 2: Symlink individual skills (stay in sync with `git pull`)

```bash
mkdir -p ~/.claude/skills
for d in "$(pwd)"/claude-code-skills/skills/*/; do
  ln -s "${d%/}" ~/.claude/skills/
done
```

## Option 3: Add one skill to a project

```bash
mkdir -p .claude/skills
cp -r claude-code-skills/skills/pr-reviewer .claude/skills/
```

Claude Code picks up new or edited skills in `~/.claude/skills/` and `.claude/skills/` without a restart. If the top-level skills directory didn't exist when the session started, run `/reload-skills`.

## Usage

Once installed, invoke a skill by name in Claude Code, or describe the task and Claude loads the matching skill from its `description`:

```
/pr-reviewer        # Review current branch changes
/test-generator     # Generate tests for changed files
/doc-writer         # Generate API documentation
/migration-assistant # Help with framework migrations
/dependency-auditor  # Audit dependencies for vulnerabilities
/db-query-helper    # Help write and optimize SQL queries
/api-contract-checker # Compare API routes with the OpenAPI spec
/ci-failure-analyzer  # Diagnose a failing GitHub Actions run
```
