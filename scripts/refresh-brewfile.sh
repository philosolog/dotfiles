#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
brewfile="$repo_dir/amac/Brewfile"
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

if ! command -v brew >/dev/null 2>&1; then
  echo "brew not found" >&2
  exit 1
fi

{
  brew tap | sort | sed 's/.*/tap "&"/'
  echo

  {
    brew leaves
    echo "ripgrep"
  } | sort -u | sed 's/.*/brew "&"/'
  echo

  brew list --cask | sort | sed 's/.*/cask "&"/'

  if command -v mas >/dev/null 2>&1; then
    mas list | awk '
      NF >= 2 {
        id=$1
        $1=""
        sub(/^ /, "")
        sub(/ *\\([^)]*\\)$/, "")
        gsub(/"/, "\\\"")
        printf "mas \"%s\", id: %s\n", $0, id
      }
    '
  fi
} > "$tmp"

mv "$tmp" "$brewfile"
echo "Wrote $brewfile"

