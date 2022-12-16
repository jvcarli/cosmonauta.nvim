-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- {{{ (Neo)vim beginner (or a little rusty)?

-- Help is your friend
-- :help user-manual

-- Make sure you grok VI:
-- SEE: https://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim/1220118#1220118

-- Make sure you understand VIM a little:
-- SEE: https://www.reddit.com/r/vim/wiki/index/
-- SEE: https://github.com/mhinz/vim-galore
-- SEE: https://developer.ibm.com/articles/l-vim-script-1/
-- SEE: https://devhints.io/vimscript-functions
-- SEE: https://blog.joren.ga/vim-learning-steps

-- Make sure you understand Neovim and its lua ecosystem a little:
-- SEE: https://github.com/nanotee/nvim-lua-guide
-- SEE: https://github.com/rockerBOO/awesome-neovim
-- SEE: https://github.com/LunarVim/Neovim-from-scratch

-- Counterarguments against using vim
-- Don't use vim
-- SEE: https://gist.github.com/romainl/6b952db7a6138b48657ba0fbb9d65370
--
-- Modern IDEs are magic. Why are so many coders still using Vim and Emacs?
-- SEE: https://stackoverflow.blog/2020/11/09/modern-ide-vs-vim-emacs/

-- Extras:
-- Vim Script for Python Developers:
-- SEE: https://gist.github.com/yegappan/16d964a37ead0979b05e655aa036cad0

-- }}}

-- {{{ Lua modules vs lua scripts

-- Regarding Neovim there are two types of Lua files: scripts and modules.
--
-- Scripts work like Vim script files, you put them into your
-- plugin, ftplugin, autoload, syntax or another directory
-- inside your runtimepath (SEE: `:h 'runtimepath')
-- and they will be sourced automatically when appropriate,
-- like Vim script files.
--
-- Modules are like a library that can be loaded using lua's require function
-- and has a single global name containing a lua table.
-- Basically a module's a Lua file (or multiple files) that is NOT sourced automatically.
-- You have to load them explicitly using the require function. They must be inside the lua directory of the runtime path directory.
-- SEE: https://www.reddit.com/r/neovim/comments/rjbkn8/is_it_necessary_to_put_all_my_lua_files_in_a/

-- }}}

-- {{{ Vimscript is a pain

-- Yes, writing it is a pain.
-- Does it have an autoformatter like prettier, stylua, etc?
-- No:
--   SEE: https://www.reddit.com/r/vim/comments/8k1ljk/vim_script_formatter/
--   SEE: https://www.reddit.com/r/vim/comments/dreuhu/vimscript_formatter/
--   SEE: https://github.com/vim-jp/vim-vimlparser
--   SEE: https://github.com/vim-jp/go-vimlparser

-- }}}

-- {{{ Neovim script loading order (*.lua and *.vim files)

-- SEE: https://www.reddit.com/r/neovim/comments/ny3oem/confused_by_order_of_loading_scripts/

-- `plugin/` directory and its files gets sourced AFTER this (~/.config/init.lua) file

-- }}}

-- {{{ Relevant Neovim Github issues

-- Following HEAD: breaking changes on master
-- TODO: verify for any changes starting from APRIL/2022
-- SEE: https://github.com/neovim/neovim/issues/14090

-- Autocmd for remote plugin on VimEnter is slow
-- SEE: https://github.com/neovim/neovim/issues/5728

-- UI extension work (tracking issue)
-- SEE: https://github.com/neovim/neovim/issues/9421

-- Insert completion: allow for custom filtering of completion matches using lua functions
-- SEE: https://github.com/neovim/neovim/pull/13854

-- autocmd CursorHold and CursorHoldI are blocked by timer_start()
-- SEE: https://github.com/neovim/neovim/issues/12587

-- Highlighting Folded
-- Vim folding makes me want to cry
-- SEE:  https://github.com/neovim/neovim/issues/12649

-- spell checker integration #12064
-- SEE: https://github.com/neovim/neovim/issues/12064
-- }}}

-- {{{ Relevant Neovim pull requests

-- feat(api): add support for lua function & description in keymap
-- SEE: https://github.com/neovim/neovim/pull/16594
-- SEE: https://www.reddit.com/r/neovim/comments/rt0zzh/featapi_add_support_for_lua_function_description/

-- Add textDocument/foldingRange capability to LSP client #14306
-- SEE: https://github.com/neovim/neovim/pull/14306

-- feat(lsp): add support for semantic tokens
-- SEE: https://github.com/neovim/neovim/pull/15723

-- [WIP] winbar
-- SEE: https://github.com/neovim/neovim/pull/17336

--  feat(ui): inline virtual text #20130
--  SEE: https://github.com/neovim/neovim/pull/20130
--  SEE: https://www.reddit.com/r/neovim/comments/z56k34/question_infix_inlay_hints/

-- }}}

-- {{{ How to time profile Neovim startup time

-- {{{ Vanilla Neovim

-- from: https://stackoverflow.com/questions/12213597/how-to-see-which-plugins-are-making-vim-slow

-- Neovim responsiveness:
--    Launch a file with nvim and do:
--    :profile start profile.log
--    :profile func *
--    :profile file *
-- At this point do slow actions that you want to profile
--    :profile pause
--    :noautocmd qall!

-- Detailed startup time:
-- nvim --startuptime timeCost.log timeCost.log
-- NOTE: timeCost.log is duplicated on the command on purpose, Neovim will create the file containing detailed profiling
--       and will open it inside Neovim after

-- }}}

--  {{{ Thirdy-party plugins

-- Packer plugins loading time
--    Launch nvim
--    :PackerCompile profile = true
--    quit nvim and launch it again
--    :PackerProfile

-- Install "dstein64/vim-startuptime" plugin, open Neovim and run:
--    :StartupTime

-- }}}

-- }}}

if vim.env.NVIM_DEBUG == "1" then
  dofile(vim.fn.stdpath "config" .. "/test/minimal_init.lua")
elseif vim.env.NVIM_RAW == "1" then
  dofile(vim.fn.stdpath "config" .. "/_no_plugin/init.lua")
elseif vim.g.vscode then
  -- vscode-neovim extension
  -- SEE: https://github.com/vscode-neovim/vscode-neovim

  -- MUST use absolute path because `$ code` can be called form any directory.
  dofile(vim.fn.stdpath "config" .. "/_vscode/init.lua")
else
  -- Ordinary Neovim, the real deal

  -- Scratch files
  vim.opt.runtimepath:append(vim.fn.stdpath "config" .. "/scratch")

  -- impatient.nvim: speed up lua imports. MUST be loaded before any other lua plugin.
  pcall(require, "impatient")

  -- Neovim vanilla settings
  require "general_settings"

  -- Packer managed plugins and its settings.
  require "plugins"

  -- Setup globals that I expect to be always available.
  require "user.modules.globals"

  -- Commands definition
  require "commands"

  -- Keymaps definition
  -- check keymaps descriptions in which-key.lua file.
  require "keymaps"

  -- Default colorscheme
  -- Persistent and synced between Neovim and Kitty terminal emulator, WIP, still buggy. Defining the theme manually.
  -- require "colorscheme"
  --
  -- light theme:
  -- vim.cmd "colorscheme zenbones-extra"
  --
  -- dark theme
  vim.cmd "colorscheme gruvbox"
end
