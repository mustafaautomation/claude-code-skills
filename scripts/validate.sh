#!/bin/bash
# Validates Claude Code skill definitions for structural correctness
set -e

ERRORS=0
TOTAL=0
SKILLS_DIR="skills"

echo "Validating Claude Code skills..."
echo ""

for dir in $SKILLS_DIR/*/; do
  TOTAL=$((TOTAL + 1))
  skill_name=$(basename "$dir")
  skill_file="$dir/skill.md"

  if [ ! -f "$skill_file" ]; then
    echo "❌ $skill_name: missing skill.md"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  if [ ! -s "$skill_file" ]; then
    echo "❌ $skill_name: skill.md is empty"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # Check for required sections
  has_title=$(head -1 "$skill_file" | grep -c "^# " || true)
  has_process=$(grep -c "^## Process" "$skill_file" || true)
  has_output=$(grep -c "^## Output" "$skill_file" || true)

  issues=""
  if [ "$has_title" -eq 0 ]; then
    issues="${issues} [missing title]"
  fi
  if [ "$has_process" -eq 0 ]; then
    issues="${issues} [missing ## Process section]"
  fi
  if [ "$has_output" -eq 0 ]; then
    issues="${issues} [missing ## Output section]"
  fi

  # Check minimum content length (at least 200 chars for a real skill)
  char_count=$(wc -c < "$skill_file" | tr -d ' ')
  if [ "$char_count" -lt 200 ]; then
    issues="${issues} [too short: ${char_count} chars]"
  fi

  if [ -n "$issues" ]; then
    echo "⚠️  $skill_name:$issues"
  else
    line_count=$(wc -l < "$skill_file" | tr -d ' ')
    echo "✅ $skill_name — ${line_count} lines, ${char_count} chars"
  fi
done

echo ""
echo "Validated $TOTAL skills, $ERRORS errors"

if [ $ERRORS -gt 0 ]; then
  exit 1
fi

echo "All skills valid!"
