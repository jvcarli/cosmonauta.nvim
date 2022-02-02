vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

vim.cmd [[
  augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#A8334C' gui=bold ctermfg=155 cterm=bold
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#88507D' gui=bold ctermfg=81 cterm=bold
  augroup END
]]
