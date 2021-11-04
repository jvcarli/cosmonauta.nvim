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
--               Formatting               --
-- =======================================--

-- Remove trailing whitespaces from declared filetypes
-- See: https://neovim.discourse.group/t/the-300-line-init-lua-challenge/227/8

-- vim.cmd([[autocmd BufWritePre * %s/\s\+$//e]])

-- =======================================--
--                 Yank                   --
-- =======================================--

-- Highlight text on yank
-- For more information see h: lua-highlight
-- The first parameter is the highlight group to use,
-- and the second is the highlight duration time in ms
-- Taken from: https://jdhao.github.io/2020/05/22/highlight_yank_region_nvim/
vim.api.nvim_exec([[
    augroup HighlightYank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=350}
    augroup END
]], false)

-- vim.cmd ([[autocmd TextYankPost * lua vim.highlight.on_yank {on_visual = false}]])

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
