# Installation

## Option 1: Clone to your Claude Code skills directory

```bash
# Clone the repo
git clone https://github.com/mustafaautomation/claude-code-skills.git

# Symlink skills into your Claude Code config
ln -s $(pwd)/claude-code-skills/skills ~/.claude/skills
```

## Option 2: Copy individual skills

```bash
# Copy a specific skill
cp -r skills/pr-reviewer ~/.claude/skills/
```

## Option 3: Reference in settings.json

Add to your `.claude/settings.json`:

```json
{
  "skills": {
    "directories": [
      "/path/to/claude-code-skills/skills"
    ]
  }
}
```

## Usage

Once installed, invoke skills in Claude Code:

```
/pr-reviewer        # Review current branch changes
/test-generator     # Generate tests for changed files
/doc-writer         # Generate API documentation
/migration-assistant # Help with framework migrations
/dependency-auditor  # Audit dependencies for vulnerabilities
/db-query-helper    # Help write and optimize SQL queries
```
