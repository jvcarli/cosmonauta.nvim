local zenbones_status_ok = pcall(require, "zenbones")
if not zenbones_status_ok then
  -- zenbones.nvim is not installed
  return
else
  -- Setup default zenbones theme
  vim.cmd "set background=light"
  vim.cmd "runtime colors/zenbones.vim"

  -- Setup zenbones extra highlight groups
  -- TODO: use lush.nvim to extend this colorscheme

  -- ntpeters/vim-better-whitespace
  vim.cmd "highlight ExtraWhitespace guibg=#A8334C"

  -- rhysd/clever-f.vim
  vim.cmd "highlight CleverFDefaultLabel cterm=bold ctermfg=9 gui=bold guifg=#A8334C"

  -- Remove tildes from blank lines
  -- For some reason this has to be in the bottom off the config file
  -- taken from: https://stackoverflow.com/questions/3813059/is-it-possible-to-not-display-a-for-blank-lines-in-vim-neovim
  -- vim.cmd "hi NonText guifg=bg" -- is problematic when "eol" and "space" list_chars are used because it omits they.
end
