#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="$repo_dir/amac"

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if ! command -v chezmoi >/dev/null 2>&1; then
  echo "chezmoi not found" >&2
  exit 1
fi

"$repo_dir/scripts/refresh-brewfile.sh"
chezmoi --source "$source_dir" re-add

if command -v rg >/dev/null 2>&1; then
  secret_pattern='(token|secret|password|passwd|api[_-]?key|apikey|credential|bearer|oauth|client_secret|BEGIN .*PRIVATE KEY|ghp_|github_pat_|sk-[A-Za-z0-9]|xox[baprs]-|_auth)'
  if rg -n --hidden --no-ignore --glob '!Brewfile' -i "$secret_pattern" "$source_dir"; then
    echo "Secret-like strings found. Review output; not committing." >&2
    exit 1
  fi
fi

git -C "$repo_dir" add .gitignore README.md amac scripts

if git -C "$repo_dir" diff --cached --quiet; then
  ahead_count="$(git -C "$repo_dir" rev-list --count @{upstream}..HEAD 2>/dev/null || echo 0)"
  if [[ "$ahead_count" != "0" ]]; then
    git -C "$repo_dir" pull --rebase --autostash
    git -C "$repo_dir" push
  else
    echo "No dotfile changes to sync."
  fi
  exit 0
fi

git -C "$repo_dir" commit -m "Update amac recovery state"
git -C "$repo_dir" pull --rebase --autostash
git -C "$repo_dir" push
