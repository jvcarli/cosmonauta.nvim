#!/usr/bin/env bash

echo "Installing or upgrading language servers managed by macOS Homebrew..."

brew_installed_ls=("efm-langserver" "texlab")

for server in "${brew_installed_ls[@]}"; do
	brew upgrade "$server"
done
