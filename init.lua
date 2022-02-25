-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- {{{ (Neo)vim beginner (or a little rusty)?

-- Make sure you grok VI:
-- see: https://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim/1220118#1220118

-- Make sure you understand VIM a little:
-- see: https://www.reddit.com/r/vim/wiki/index/
-- see: https://github.com/mhinz/vim-galore

-- Make sure you understand Neovim and its lua ecosystem a little:
-- see: https://github.com/nanotee/nvim-lua-guide
-- see: https://github.com/rockerBOO/awesome-neovim
-- see: https://github.com/LunarVim/Neovim-from-scratch

-- }}}

-- {{{ Lua modules vs lua scripts

-- Regarding Neovim there are two types of Lua files: scripts and modules.
--
-- Scripts work like Vim script files, you put them into your
-- plugin, ftplugin, autoload, syntax or whatever directory
-- inside your runtimepath (see: `:h 'runtimepath')
-- and they will be sourced automatically (when appropriate),
-- like Vim script files.
--
-- Module is like a library that can be loaded using require
-- and has a single global name containing a table
-- Basically a module's a Lua file which is NOT sourced automatically.
-- You have to load them explicitly using the require function. These must be inside the lua directory of the runtime path directory.
-- see: https://www.reddit.com/r/neovim/comments/rjbkn8/is_it_necessary_to_put_all_my_lua_files_in_a/

-- }}}

-- {{{ Neovim script loading order (*.lua and *.vim files)

-- see: https://www.reddit.com/r/neovim/comments/ny3oem/confused_by_order_of_loading_scripts/

-- `plugin/` directory and its files gets sourced AFTER this file
-- }}}

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

-- {{{ Relevant Neovim pull requests

-- Enable new diff option linematch #14537
-- see: https://github.com/neovim/neovim/pull/14537

-- feat(api): add support for lua function & description in keymap
-- see: https://github.com/neovim/neovim/pull/16594
-- see: https://www.reddit.com/r/neovim/comments/rt0zzh/featapi_add_support_for_lua_function_description/

-- Add textDocument/foldingRange capability to LSP client #14306
-- see: https://github.com/neovim/neovim/pull/14306

-- }}}

-- {{{ How to time profile

-- {{{ Vanilla Neovim

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

--  {{{ Thirdy-party plugins

-- Install "dstein64/vim-startuptime" plugin, open Neovim and run:
-- `:StartupTime`

-- }}}

-- }}}

-- {{{ VSCode Neovim Integration

-- TODO: Include specific VSCode Neovim configuration,
-- see: https://github.com/vscode-neovim/vscode-neovim

-- if vim.g.vscode then
--   -- VSCODE conf
--   print('vscode conf enabled')
-- else
--   -- raw neovim conf
--   print('neovim conf enabled')
-- end

-- }}}

-- impatient.nvim: speed up lua imports. MUST be loaded before any other lua plugin.
pcall(require, "impatient")

-- Vanilla settings (doesn't depend on external plugins).
require "general_settings"

-- Packer managed plugins and its settings.
require "plugins"

-- Setup globals that I expect to be always available.
require "globals"

-- Keymaps definition
-- check keymaps descriptions in which-key.lua file.
require "keymaps"

-- Default colorscheme
vim.cmd "colorscheme zenbones-extra"
-- vim.cmd "colorscheme catppuccin"
-- No magic: some distro packages come bundled with vim plugins
-- e.g.: fzf and black ($ sudo pacman -S fzf python-black)
-- those plugin get stored under the path below
-- don't allow these because the setup starts to be less portable
-- prefer to explicitly install things
vim.cmd "set rtp-=/usr/share/vim/vimfiles"

-- Remove useless default colors, HOW??? The command below doesn't work
-- vim.cmd "set runtimepath-=/usr/share/nvim/runtime/colors"
