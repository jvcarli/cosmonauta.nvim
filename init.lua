-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- {{{ Following Neovim HEAD (Breaking changes) / Relevant Neovim GitHub issues

-- Updated breaking changes
-- see: https://github.com/neovim/neovim/issues/14090

-- Autocmd for remote plugin on VimEnter is slow
-- see: https://github.com/neovim/neovim/issues/5728

-- UI extension work (tracking issue)
-- see: https://github.com/neovim/neovim/issues/9421

-- Insert completion: allow for custom filtering of completion matches using lua functions
-- see: https://github.com/neovim/neovim/pull/13854

-- autocmd CursorHold and CursorHoldI are blocked by timer_start()
-- see: https://github.com/neovim/neovim/issues/12587

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

-- impatient.nvim: speed up lua imports. MUST be loaded before any other lua plugin
require "impatient"

-- Vanilla settings
require "general_settings"

-- Packer managed plugins and its settings
require "plugins"
-- Non default packer_compiled location so impatient.nvim can cache it
require "packer/packer_compiled"

-- keymaps definition
-- keymaps namings are in which-key.lua
require "keymaps"

-- Default color theme
vim.cmd "colorscheme zenbones"
vim.cmd "set background=light"
