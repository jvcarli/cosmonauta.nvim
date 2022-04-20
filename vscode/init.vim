" Vscode-neovim init file
" SEE: https://github.com/vscode-neovim/vscode-neovim
" Using a init.lua file is possible too.

" exclude unnecessary directories from vscode config
" ~/.config/nvim/vscode/lua will be lua runtime path for vscode
" instead of the default ~/.config/nvim/lua
set runtimepath=~/.config/nvim/vscode,/etc/xdg/nvim,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/share/nvim/runtime,/usr/share/nvim/runtime/pack/dist/opt/matchit,/usr/lib/nvim,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/etc/xdg/nvim/after,/usr/share/vim/vimfiles

" DO NOT use default packpath (~/.local/share/nvim/site/*) as packer.nvim
" plugin manager uses it.
set packpath=

lua require "keymaps"
