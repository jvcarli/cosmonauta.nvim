-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- {{{ Relevant Neovim Github issues

-- Following HEAD: breaking changes on master
-- see: https://github.com/neovim/neovim/issues/14090

-- Autocmd for remote plugin on VimEnter is slow
-- see: https://github.com/neovim/neovim/issues/5728

-- UI extension work (tracking issue)
-- see: https://github.com/neovim/neovim/issues/9421

-- Insert completion: allow for custom filtering of completion matches using lua functions
-- see: https://github.com/neovim/neovim/pull/13854

-- autocmd CursorHold and CursorHoldI are blocked by timer_start()
-- see: https://github.com/neovim/neovim/issues/12587

-- Highlighting Folded
-- Vim folding makes me want to cry
-- see:  https://github.com/neovim/neovim/issues/12649

-- }}}

-- {{{ How to time profile

-- from: https://stackoverflow.com/questions/12213597/how-to-see-which-plugins-are-making-vim-slow

-- Neovim responsiveness:
--     launch a file with nvim
--     :profile start profile.log
--     :profile func *
--     :profile file *
-- At this point do slow actions that you want to profile
--     :profile pause
--     :noautocmd qall!

-- Packer plugins loading time
--     launch nvim
--     :PackerCompile profile = true
--     quit nvim and launch it again
--     :PackerProfile

-- Detailed startup time:
-- nvim --startuptime timeCost.log timeCost.log

-- }}}

-- {{{ VSCode configuration

-- TODO: Include VSCode configuration,

-- if vim.g.vscode then
--   -- VSCODE conf
--   print('vscode conf enabled')
-- else
--   -- raw neovim conf
--   print('neovim conf enabled')
-- end

-- }}}

-- {{{ lua MODULES vs lua SCRIPTS

-- There are two types of Lua files: scripts and modules.
--
-- Scripts work like Vim script files, you put them into your plugin, ftplugin, autoload, syntax or whatever directory (see: `:h 'runtimepath')
-- and they will be sourced automatically (when appropriate), like Vim script files.
--
-- Modules are Lua files which are not sourced automatically.
-- You have to load them explicitly using the require function. These must be inside the lua directory of the runtime path directory.
-- see: https://www.reddit.com/r/neovim/comments/rjbkn8/is_it_necessary_to_put_all_my_lua_files_in_a/

-- }}}

-- impatient.nvim: speed up lua imports. MUST be loaded before any other lua plugin
pcall(require, "impatient")

-- Vanilla settings
require "general_settings"

-- Packer managed plugins and its settings
require "plugins"
require "packer/packer_compiled"

-- keymaps definition
-- check keymaps descriptions in which-key.lua file
require "keymaps"

-- Default color theme
vim.cmd "colorscheme zenbones"
vim.cmd "set background=light"
-- plugin/ directory and its files gets sourced AFTER init.lua
