local catppuccin_status_ok = pcall(require, "catppuccin")
if not catppuccin_status_ok then
  -- catppuccin is not installed
  return
else
  -- local color_palette = require "catppuccin/core/color_palette"
  local color_palette = require("catppuccin.api.colors").get_colors()
  -- Setup default catppuccin theme
  vim.cmd "runtime colors/catppuccin.vim"

  -- Setup catppuccin extra highlight groups
  -- TODO: use lush.nvim to extend this colorscheme?

  -- marks.nvim
  -- no color in marked line signcolumn number
  vim.cmd "highlight MarkSignNumHL guibg=none guifg=none"

  -- rhysd/clever-f.vim
  vim.cmd("highlight CleverFDefaultLabel gui=bold guifg=" .. color_palette.red)

  -- Dirbuf.nvim
  vim.cmd("highlight DirbufDirectory gui=bold guifg=" .. color_palette.blue) -- Blue
  -- vim.cmd "highlight DirbufFile guibg=red"

  -- Remove tildes from blank lines
  -- For some reason this has to be in the bottom off the config file
  -- taken from: https://stackoverflow.com/questions/3813059/is-it-possible-to-not-display-a-for-blank-lines-in-vim-neovim
  -- is problematic when "eol" and "space" list_chars are used because it omits they.
  -- vim.cmd "highlight NonText guifg=bg"
end
