-- Test init file
-- Inspired by minimal_init.lua
-- SEE: https://github.com/neovim/nvim-lspconfig/blob/master/test/minimal_init.lua
-- WARN: this file is used to set up the correct runtimepath for testing, and
--       shouldn't be used directly. Use ./test.lua as the regular init.lua.
--       If it doesn't exist create one.
--       This is done so one can freely change files and directories for testing
--       without cluterring git status.

-- WARN: For all purposes ~/.config/nvim/test will behave like ~/.config/nvim,
--       so ~/.config/nvim/test/lua will be set to be the lua runtime path
--       for Neovim instead of the default ~/.config/nvim/lua.
vim.opt.runtimepath:prepend("~/.config/nvim/test")

-- NOTE: if we include ~/.config/nvim we'll load
--       ftplugins, plugins, etc... from its standards locations.
--       We don't want that.
-- TODO: find a lua version for this command.
--       For some reason vim.opt.runtimepath:remove("~/.config/nvim") doesn't work
vim.cmd([[set runtimepath-=~/.config/nvim]])

local test_file = vim.fn.stdpath("config") .. "/test/test.lua"

if vim.fn.filereadable(test_file) == 1 then
  dofile(test_file)
else
  vim.print("Please place a test file at ~/.config/nvim/test/test.lua")
end
