#!/usr/bin/env bash
# SessionEnd Hook Script (Linux/Mac)
# Automatically records timestamp to RESUME.md on session close
# Called by SessionEnd hook in settings.local.json

set -e

PROJECT_DIR="${1:-$PWD}"
RESUME_PATH="$PROJECT_DIR/RESUME.md"

if [ ! -f "$RESUME_PATH" ]; then
  exit 0
fi

NOW=$(date '+%Y-%m-%d %H:%M:%S')
TODAY=$(date '+%Y-%m-%d')

# Update last_updated timestamp
sed -i "s/- \*\*last_updated\*\*:.*/- **last_updated**: $TODAY/" "$RESUME_PATH"

# Append or update session_end marker
if grep -q 'last_session_end' "$RESUME_PATH"; then
  sed -i "s/- \*\*last_session_end\*\*:.*/- **last_session_end**: $NOW/" "$RESUME_PATH"
else
  echo "" >> "$RESUME_PATH"
  echo "- **last_session_end**: $NOW" >> "$RESUME_PATH"
fi

echo "SessionEnd: RESUME.md checkpoint updated at $NOW"
