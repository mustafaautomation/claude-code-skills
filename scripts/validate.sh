#!/usr/bin/env bash
# Validates Claude Code skills: <skill-name>/SKILL.md with YAML frontmatter
# (name, description) plus the sections this repo requires.
# Exits non-zero if any skill has a problem.
set -uo pipefail

SKILLS_DIR="${1:-skills}"
ERRORS=0
TOTAL=0

fail() { echo "❌ $1: $2"; ERRORS=$((ERRORS + 1)); }

shopt -s nullglob
dirs=("$SKILLS_DIR"/*/)
if [ ${#dirs[@]} -eq 0 ]; then
  echo "❌ no skill directories found in $SKILLS_DIR"
  exit 1
fi

echo "Validating Claude Code skills in $SKILLS_DIR..."
echo ""

for dir in "${dirs[@]}"; do
  TOTAL=$((TOTAL + 1))
  skill=$(basename "$dir")
  file="${dir%/}/SKILL.md"
  before=$ERRORS

  if [ -e "${dir%/}/skill.md" ] && [ ! -e "$file" ]; then
    fail "$skill" "uses legacy lowercase skill.md; rename to SKILL.md"
    continue
  fi
  if [ ! -s "$file" ]; then
    fail "$skill" "missing or empty SKILL.md"
    continue
  fi

  # Frontmatter: first line must be ---, closed by a second ---
  if [ "$(head -n 1 "$file")" != "---" ]; then
    fail "$skill" "SKILL.md must start with YAML frontmatter (first line '---')"
    continue
  fi
  close=$(awk 'NR>1 && /^---[[:space:]]*$/ {print NR; exit}' "$file")
  if [ -z "$close" ]; then
    fail "$skill" "frontmatter is not closed with '---'"
    continue
  fi
  fm=$(sed -n "2,$((close - 1))p" "$file")
  body=$(sed -n "$((close + 1)),\$p" "$file")

  name=$(printf '%s\n' "$fm" | sed -n 's/^name:[[:space:]]*//p' | head -n 1 | sed 's/[[:space:]]*$//; s/^["'\'']//; s/["'\'']$//')
  desc=$(printf '%s\n' "$fm" | sed -n 's/^description:[[:space:]]*//p' | head -n 1 | sed 's/[[:space:]]*$//')

  if [ -z "$name" ]; then
    fail "$skill" "frontmatter missing 'name'"
  elif ! [[ "$name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] || [ ${#name} -gt 64 ]; then
    fail "$skill" "name '$name' must be lowercase letters, digits and hyphens (max 64)"
  elif [ "$name" != "$skill" ]; then
    fail "$skill" "name '$name' does not match directory name"
  fi

  if [ -z "$desc" ]; then
    fail "$skill" "frontmatter missing 'description'"
  elif [ ${#desc} -gt 1024 ]; then
    fail "$skill" "description longer than 1024 characters"
  fi

  printf '%s\n' "$body" | grep -q '^# ' || fail "$skill" "missing '# Title' heading"
  printf '%s\n' "$body" | grep -q '^## Process' || fail "$skill" "missing '## Process' section"
  printf '%s\n' "$body" | grep -q '^## Output' || fail "$skill" "missing '## Output' section"

  chars=$(printf '%s' "$body" | wc -c | tr -d ' ')
  [ "$chars" -ge 200 ] || fail "$skill" "body too short (${chars} chars, need 200)"

  if [ $ERRORS -eq $before ]; then
    echo "✅ $skill: $(wc -l < "$file" | tr -d ' ') lines"
  fi
done

echo ""
echo "Validated $TOTAL skills, $ERRORS errors"
if [ $ERRORS -gt 0 ]; then
  exit 1
fi
echo "All skills valid!"
