# Cosmonauta.nvim

Neovim custom configuration for macos, Arch Linux and Windows.

This code is constantly changing and **has NOT**
reached a stable state yet.

## Requirements

- [Neovim HEAD](https://github.com/neovim/neovim/commits/master)

**NOTE**: all the dependencies should be resolved by a bootstrap script
that is triggered automatically when running Neovim for the first time.
The script relies on package managers for _external dependencies_,
i.e. dependencies that are not Neovim plugins. (e.g. [`ripgrep`](https://github.com/BurntSushi/ripgrep), [`fd`](https://github.com/sharkdp/fd), etc)

- macos **requires** [Homebrew](https://brew.sh/) package manager
- Arch Linux **requires** [yay](https://github.com/Jguer/yay) package manager
  which will install AUR packages when needed
- Windows: **not supported** yet

## Install

Copy this repository to `~/.config/nvim` then run `$ nvim`.
