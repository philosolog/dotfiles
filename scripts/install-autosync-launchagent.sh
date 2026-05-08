#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
plist="$HOME/Library/LaunchAgents/com.philosolog.dotfiles-sync.plist"
log_dir="$HOME/Library/Logs"

mkdir -p "$(dirname "$plist")" "$log_dir"

cat > "$plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.philosolog.dotfiles-sync</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>$repo_dir/scripts/sync-amac-dotfiles.sh</string>
  </array>
  <key>StartInterval</key>
  <integer>86400</integer>
  <key>RunAtLoad</key>
  <true/>
  <key>StandardOutPath</key>
  <string>$log_dir/dotfiles-sync.log</string>
  <key>StandardErrorPath</key>
  <string>$log_dir/dotfiles-sync.err.log</string>
</dict>
</plist>
PLIST

launchctl unload "$plist" >/dev/null 2>&1 || true
launchctl load "$plist"
echo "Installed auto-sync LaunchAgent: $plist"
