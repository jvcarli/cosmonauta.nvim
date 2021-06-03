-- =======================================--
--           Augroups and autocmd         --
-- =======================================--

-- Commands inside vim.cmd and vim.api.nvim_exec are coded with VIM SCRIPT
-- because augroups and autocommands DO NOT have an interface yet,
-- This is being worked on, see: https://github.com/neovim/neovim/pull/12378

-- =======================================--
--           Smart Number Toggle          --
-- =======================================--

-- https://github.com/jeffkreeftmeijer/vim-numbertoggle
-- vim-numbertoggle - Automatic toggling between 'hybrid' and absolute line numbers
-- Maintainer:        <https://jeffkreeftmeijer.com>
-- Version:           2.1.2

vim.api.nvim_exec([[
    augroup SmartNumberToggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    augroup end
]], false)

-- =======================================--
--                 Yank                   --
-- =======================================--

-- Highlight text on yank
vim.cmd "autocmd TextYankPost * lua vim.highlight.on_yank {on_visual = false}"

-- =======================================--
--                 Packer                 --
-- =======================================--

-- Auto compile when there are changes in plugins/init.lua
vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]], false)
