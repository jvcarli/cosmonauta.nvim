-- Tomorrow-night color scheme
-- Derived from base16-tomorrow-night
-- SEE: https://github.com/chriskempson/base16-vim/blob/master/colors/base16-tomorrow-night.vim

local palette = {
  base00 = "#1d1f21",
  base01 = "#282a2e",
  base02 = "#373b41",
  base03 = "#969896",
  base04 = "#b4b7b4",
  base05 = "#c5c8c6",
  base06 = "#e0e0e0",
  base07 = "#ffffff",
  base08 = "#cc6666",
  base09 = "#de935f",
  base0A = "#f0c674",
  base0B = "#b5bd68",
  base0C = "#8abeb7",
  base0D = "#81a2be",
  base0E = "#b294bb",
  base0F = "#a3685a",
}

if palette then
  require("mini.base16").setup { palette = palette, use_cterm = false }
  vim.g.colors_name = "tomorrow_night"
end

vim.cmd [[highlight DiagnosticUnderlineError gui=undercurl ]]
vim.cmd [[highlight DiagnosticUnderlineWarn  gui=undercurl ]]
vim.cmd [[highlight DiagnosticUnderlineInfo  gui=undercurl ]]
vim.cmd [[highlight DiagnosticUnderlineHint  gui=undercurl ]]
