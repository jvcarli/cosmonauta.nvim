-- Vim commands that weren't ported to lua already

-- autocmds
-- Commands inside vim.cmd are coded with vimscript because
-- augroups and autocommands DO NOT have an interface yet,
-- but is being worked on, see: https://github.com/neovim/neovim/pull/12378

-- =======================================--
--     Tabs and spaces configuration      --
-- =======================================--

-- Golang
-- Typescript JSX
vim.cmd[[autocmd FileType typescriptreact setlocal softtabstop=2 shiftwidth=2 expandtab]]
-- Typescrpt 
vim.cmd[[autocmd FileType typescript setlocal softtabstop=2 shiftwidth=2 expandtab]]
-- Javascript
vim.cmd[[autocmd FileType javascript setlocal softtabstop=2 shiftwidth=2 expandtab]]
-- Html
vim.cmd[[autocmd FileType html setlocal softtabstop=2 shiftwidth=2 expandtab]]
-- Svelte
vim.cmd[[autocmd FileType svelte setlocal softtabstop=2 shiftwidth=2 expandtab]]

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
