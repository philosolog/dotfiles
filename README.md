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
Optional: install a LaunchAgent that runs sync at login and daily:
```sh
~/dotfiles/scripts/install-autosync-launchagent.sh
```

Never tracked: shell histories, SSH keys, Docker auth config, WakaTime config, app preference plists by default, and cached/binary editor data.
