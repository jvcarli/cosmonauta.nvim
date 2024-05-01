-- Interesting take and setup on vim and latex
-- SEE: https://castel.dev/post/lecture-notes-1/#vim-and-latex
-- SEE: https://www.learnlatex.org/en/
-- SEE: https://www.ejmastnak.com/tutorials/vim-latex/intro.html

local is_mac = require("user.modules.utils").is_mac
local is_linux = require("user.modules.utils").is_linux

-- TODO: align Nvim compiler setup with Overleaf so your pure offline setup
--       works like your Overleaf setup, making sharing easier.

-- TODO: autocmd for enabling a specific Neovim socket for when editing LaTeX
--       and seeing them with Skim pdf viewer. Do the same for Zathura pdf viewer.
--       SEE: https://jdhao.github.io/2021/02/20/inverse_search_setup_neovim_vimtex/
--       SEE: https://github.com/neovim/neovim/issues/1750

-- Setup Vim Digraphs and Ligatures
-- TODO: https://alpha2phi.medium.com/vim-digraphs-and-ligatures-7dec3cb0a623

-- WARN: Setting g:vimtex_compiler_progname IS NOT necessary anymore, it was deprecated

vim.g.tex_flavor = "latex"

if is_mac then
  -- You can choose the pdf viewer for your rendered .tex files
  -- Skim application has the best GUI. It's macos only
  --
  -- Zathura can be used on macos, although the setup on macos is more involved than on Linux.
  -- TODO: remember to include ~/.config/zathura/* on your dotfiles repository
  -- It has the best keyboard support.
  --
  -- TODO: include zathura setup process on macos
  -- macos builtin Preview app can be used too
  vim.g.vimtex_view_method = "skim"

  -- For using Skim app:
  --  1. set vimtex options inside Neovim conf:
  --  vim.g.vimtex_view_method = "skim"
  --
  --  2. Set Skim GUI options:
  --    Skim -> Preferences... -> Sync
  --      DO NOT check any of the checkboxes
  --
  --      Preset: Custom
  --      Command: nvr
  --      Arguments: --remote +"%line" "%file"

  -- For backward search to work from Skim (or another pdf viewer)
  -- neovim must be invoked with:
  --   `$ NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim file.tex`
  -- because nvr needs a socket to act on.
  --
  -- SEE: https://github.com/lervag/vimtex/issues/1576
end

if is_linux then
  vim.g.vimtex_view_method = "zathura"
end

-- TODO: setup vimtex_view_method for Windows

-- This option controls the behaviour of the quickfix window in case errors and/or warnings are found.
-- mode 2 (default value):
--   The quickfix window is opened automatically when there are errors,
--   but it does not become the active window.
vim.g.vimtex_quickfix_mode = 0 -- Never opens the quickfix window by default because it's really annoying

-- TODO: setup vim-matchup plugin behavior with Vimtex
-- TODO: watch for the conflicts with vim-unimpaired

-- TODO: see if setting this option is working, i.e. do I need to use set it to 0 or false in lua?
vim.g.vimtex_imaps_enabled = 0 -- disable insert mode mappings for vimtex because I use snippets

-- -verbose and -file-line-error are needed for error handling inside vim (errorformat)
-- and better debugging log within vimtex
--
-- WARN: the rest of the options should be set by project (i.e. locally) using a .latexmkrc file
-- Ideally use a Makefile (see the implications of makefiles on Windows)
vim.g.vimtex_compiler_latexmk = {
  out_dir = "../build",
  callback = 1,
  continuous = 1,
  executable = "latexmk",
  hooks = {},
  options = {
    "-verbose",
    "-file-line-error",
    "--shell-escape",
  },
}
