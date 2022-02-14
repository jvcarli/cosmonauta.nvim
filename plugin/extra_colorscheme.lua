-- Extra colorscheme highlight groups
-- apply for zenbones

-- TODO: use an autocmd for this!!

if vim.g.colors_name == "zenbones" then
  -- ntpeters/vim-better-whitespace
  vim.cmd "highlight ExtraWhitespace guibg=#A8334C"

  -- rhysd/clever-f.vim
  vim.cmd "highlight CleverFDefaultLabel cterm=bold ctermfg=9 gui=bold guifg=#A8334C"
end
