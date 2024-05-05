-- Test init file
-- Inspired by minimal_init.lua
-- SEE: https://github.com/neovim/nvim-lspconfig/blob/master/test/minimal_init.lua

-- WARN: For all purposes ~/.config/nvim/test will behave like ~/.config/nvim
--       ~/.config/nvim/test/lua will be set to be the lua runtime path
--       for Neovim instead of the default ~/.config/nvim/lua.
vim.opt.runtimepath:prepend("~/.config/nvim/test")

-- NOTE: if we include ~/.config/nvim we'll load
--       ftplugins, plugins, etc...
-- TODO: find a lua version for this command.
--       For some reason vim.opt.runtimepath:remove("~/.config/nvim") doesn't work
vim.cmd([[set runtimepath-=~/.config/nvim]])

-- Load any desired module
-- require("<module_name>")
