# Dotfiles

Arch Linux dotfiles managed with GNU Stow, plus optional package manifests and Nix tooling.

```bash
git clone https://github.com/leandergangso/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

Install the command runner if needed:

```bash
sudo pacman -S --needed go-task
```

## Stow

The root `.stowrc` uses `stow/` as the package directory and `$HOME` as the
target.

```bash
task stow -- git nvim zsh
task stow:restow -- nvim
task stow:delete -- nvim
task stow:adopt -- zsh
task stow:overwrite -- zsh
task stow:all
```

After `--adopt`, review `git diff` and restore changes you do not want.
`stow:overwrite` replaces conflicts with the current files from the selected
package and renews its links.

## Arch

Review `arch/packages/` before installing, especially drivers and kernels.

```bash
task arch:yay
task arch:install
task arch:export
```

Export will backup the previous manifests under the git-ignored `arch/backups/`.

## Nix

Add the Nix profile to your shell rc-file:

```bash
export PATH="$HOME/.nix-profile/bin:$PATH"
```

Restart the shell or source its config, then install the desired profile:

```bash
task nix:install
task nix:neovim
```

Nix is optional, but the Neovim config expects its external tools on `PATH`.

Run `task` to list all available commands. The underlying `stow`, Nix, and
`arch/*.sh` commands remain usable directly.
