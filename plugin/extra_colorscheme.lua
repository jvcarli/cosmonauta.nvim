-- Extra colorscheme highlight groups
-- apply for zenbones

-- TODO: use an autocmd for this!!

if vim.g.colors_name == "zenbones" then
  -- ntpeters/vim-better-whitespace
  vim.cmd "highlight ExtraWhitespace guibg=#A8334C"

  -- rhysd/clever-f.vim
  vim.cmd "highlight CleverFDefaultLabel cterm=bold ctermfg=9 gui=bold guifg=#A8334C"

  -- nanozuki/tabby.nvim
  -- vim.cmd "highlight TabLine cterm=underline ctermfg=0 ctermbg=7 gui=italic guifg=#2C363C guibg=#c4b6af"

  -- BUG: tabby highlight colors are defined wrong
  -- vim.cmd "highlight TabLineFill cterm=reverse gui=reverse guifg=#FF0000 guibg=#FF0000"
  -- vim.cmd "highlight TabLineSel cterm=bold gui=bold guifg=#FF0000 guibg=#FF0000"
end
