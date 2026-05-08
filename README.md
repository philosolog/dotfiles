# Dotfiles

Machine-specific dotfiles managed by chezmoi.

## amac

Install on this workstation:

```sh
git clone https://github.com/philosolog/dotfiles.git ~/dotfiles
chezmoi init --source ~/dotfiles/amac
chezmoi apply
```

Update tracked files from this machine:

```sh
chezmoi --source ~/dotfiles/amac re-add
git -C ~/dotfiles add amac
git -C ~/dotfiles commit -m "Update amac dotfiles"
git -C ~/dotfiles push
```

Excluded from the first import: shell histories, SSH keys, Docker auth config, WakaTime config, app preference plists, and cached/binary editor data.
