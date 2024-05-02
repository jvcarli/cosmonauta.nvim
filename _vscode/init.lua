-- Vscode-neovim init file
-- SEE: https://github.com/vscode-neovim/vscode-neovim
-- Using a init.vim file is possible too:
--   vim.cmd("source " .. vim.fn.stdpath "config" .. "/vscode/init.vim")

-- WARN: ~/.config/nvim/_vscode/lua will be set to be the lua runtime path
-- for vscode instead of the default ~/.config/nvim/lua.

vim.opt.runtimepath:prepend("~/.config/nvim/_vscode")

-- NOTE: if we include ~/.config/nvim we'll load
--       ftplugins, plugins, etc...
-- TODO: find a lua version for this command.
--       For some reason vim.opt.runtimepath:remove("~/.config/nvim") doesn't work
vim.cmd([[set runtimepath-=~/.config/nvim]])

-- Load modules
require("user.keymaps")
