#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="$repo_dir/amac"
brewfile="$source_dir/Brewfile"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This bootstrap is for macOS only." >&2
  exit 1
fi

if ! xcode-select -p >/dev/null 2>&1; then
  echo "Install Command Line Tools, then rerun this script:"
  echo "  xcode-select --install"
  xcode-select --install || true
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

echo "Installing packages from $brewfile..."
brew bundle --file "$brewfile" --no-upgrade

if ! command -v chezmoi >/dev/null 2>&1; then
  brew install chezmoi
fi

echo "Applying chezmoi source from $source_dir..."
chezmoi --source "$source_dir" apply

echo "Bootstrap complete."
echo "Next: sign in to 1Password, browser profiles, App Store, iCloud, and app-specific accounts."

