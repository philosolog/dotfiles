# Dotfiles

Machine-specific dotfiles managed by chezmoi.

## amac

Ocean recovery on a fresh Mac:

```sh
git clone https://github.com/philosolog/dotfiles.git ~/dotfiles
~/dotfiles/scripts/bootstrap-amac.sh
```

If the private repo cannot be cloned yet:

```sh
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install gh git chezmoi
gh auth login -h github.com
gh repo clone philosolog/dotfiles ~/dotfiles
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

Optional: install a LaunchAgent that runs sync every 30 minutes:

```sh
~/dotfiles/scripts/install-autosync-launchagent.sh
```

Never tracked: shell histories, SSH keys, Docker auth config, WakaTime config, app preference plists by default, and cached/binary editor data.
