#!/usr/bin/env bash
set -eo pipefail

quiet=0
if [[ "${1:-}" == "-q" ]]; then
  quiet=1
  shift
fi

path="${1:-}"
[[ -n "$path" && -e "$path" ]] || exit 1

if command -v xattr >/dev/null 2>&1; then
  xattr -d com.apple.metadata:kMDItemWhereFroms "$path" 2>/dev/null || true
  xattr -d com.apple.metadata:kMDItemDownloadedDate "$path" 2>/dev/null || true
  xattr -d com.apple.quarantine "$path" 2>/dev/null || true
  xattr -d com.apple.macl "$path" 2>/dev/null || true
  xattr -c "$path" 2>/dev/null || true
fi

[[ $quiet -eq 1 ]] || echo "cleared metadata: $path"
