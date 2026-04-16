#!/usr/bin/env bash
set -eo pipefail
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
SIZE_MB="${1:-90}"
LIMIT=$((SIZE_MB * 1024 * 1024))
cd "$ROOT" || exit 1

ISSUES=0
echo "Git Health Check: $ROOT"

while IFS= read -r file; do
  [[ -z "$file" ]] && continue
  [[ ! -f "$file" ]] && continue
  case "$file" in
    *.enc) continue ;;
  esac
  fsize=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo 0)
  if [[ "$fsize" -gt "$LIMIT" ]]; then
    echo "  LARGE: $file"
    ISSUES=1
  fi
done < <(git diff --cached --name-only 2>/dev/null)

while IFS= read -r git_dir; do
  [[ -z "$git_dir" ]] && continue
  [[ "$git_dir" == "$ROOT/.git" ]] && continue
  repo_dir="${git_dir%/.git}"
  relative="${repo_dir#$ROOT/}"
  git check-ignore -q "$relative" 2>/dev/null && continue
  echo "  EMBEDDED_GIT: $relative"
  ISSUES=1
done < <(python3 - "$ROOT" <<'PY'
from pathlib import Path
import sys
root = Path(sys.argv[1])
for path in root.rglob('.git'):
    print(path)
PY
)

[[ $ISSUES -eq 0 ]] && exit 0
echo "Issues found - fix before pushing"
exit 1
