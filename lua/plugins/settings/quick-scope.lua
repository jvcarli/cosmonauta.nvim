vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

vim.api.nvim_command [[augroup qs_colors]]
vim.api.nvim_command [[autocmd!]]
vim.api.nvim_command [[autocmd ColorScheme * highlight QuickScopePrimary guifg='#A8334C' gui=bold ctermfg=155 cterm=bold]]
vim.api.nvim_command [[autocmd ColorScheme * highlight QuickScopeSecondary guifg='#88507D' gui=bold ctermfg=81 cterm=bold]]
vim.api.nvim_command [[augroup END]]
