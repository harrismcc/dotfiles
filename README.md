# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

- `factory` → Factory Droid config
- `nvim` → Neovim config, tracked as a git submodule
- `shell` → shell and git config
- `zellij` → Zellij config

## Set up a new machine

```sh
git clone --recurse-submodules https://github.com/harrismcc/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Install GNU Stow:

```sh
brew install stow
```

Link everything:

```sh
stow factory nvim shell zellij
```

Or link one package at a time:

```sh
stow shell
```

To update later:

```sh
cd ~/dotfiles
git pull --recurse-submodules
git submodule update --init --recursive
stow factory nvim shell zellij
```
