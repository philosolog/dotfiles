# dotφles

My workstation dotfiles, automatically managed with [chezmoi](https://github.com/twpayne/chezmoi).

***Don't fuck up your system by proselytizing yourself into these presets if you aren't me.***

## amac

Initialization:
```sh
git clone https://github.com/philosolog/dotfiles.git ~/dotfiles
~/dotfiles/scripts/bootstrap-amac.sh
```

Manual chezmoi apply:
```sh
git clone https://github.com/philosolog/dotfiles.git ~/dotfiles
chezmoi init --source ~/dotfiles/amac
chezmoi apply
```

Update tracked files, app list, commit, and push:
```sh
~/dotfiles/scripts/sync-amac-dotfiles.sh
```
Optional: install a LaunchAgent that runs sync at login and daily at 9:00 AM local time:
```sh
~/dotfiles/scripts/install-autosync-launchagent.sh
```

If the Mac is asleep at 9:00 AM, the daily run catches up on wake. The installer
also starts a run immediately. Only dotfiles already managed by chezmoi are
refreshed; add new files with `chezmoi add` first.

Check the service with `launchctl print gui/$(id -u)/com.philosolog.dotfiles-sync`.
Logs are in `~/Library/Logs/dotfiles-sync.log` and `dotfiles-sync.err.log`.
Network or Git authentication failures are logged; another attempt occurs at the
next scheduled run or login. Git credentials must work without an interactive prompt.

Never tracked: shell histories, SSH keys, Docker auth config, WakaTime config, app preference plists by default, and cached/binary editor data.
