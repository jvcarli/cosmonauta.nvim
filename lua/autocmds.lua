-- Vim commands that weren't ported to lua already

-- autocmds
-- Commands inside vim.cmd are coded with vimscript because
-- augroups and autocommands DO NOT have an interface yet,
-- but is being worked on, see: https://github.com/neovim/neovim/pull/12378

-- =======================================--
--           Smart Number Toggle          --
-- =======================================--

-- https://github.com/jeffkreeftmeijer/vim-numbertoggle
-- vim-numbertoggle - Automatic toggling between 'hybrid' and absolute line numbers
-- Maintainer:        <https://jeffkreeftmeijer.com>
-- Version:           2.1.2

vim.cmd [[augroup smartnumbertoggle ]]
    vim.cmd [[autocmd!]]
    vim.cmd [[autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif]]
    vim.cmd [[autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif]]
vim.cmd [[augroup end ]]

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
