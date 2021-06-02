-- Vim commands that weren't ported to lua already

-- autocmds
-- Commands inside vim.cmd are coded with vimscript because
-- augroups and autocommands DO NOT have an interface yet,
-- but is being worked on, see: https://github.com/neovim/neovim/pull/12378

-- =======================================--
--                 Packer                 --
-- =======================================--

-- Packer
--
vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]], false)

-- vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
