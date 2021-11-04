-- see: https://castel.dev/post/lecture-notes-1/#vim-and-latex
-- FIX: why can't this be set in plugins.lua conf like other plugins
-- on macOS  install required latex packages with:
-- brew install --cask mactex-no-gui
vim.g.tex_flavor='latex'

-- skim is a macos only program
-- zathura can be used on linux,
-- other options such as macos built in previewer
-- other apps can be used too
-- " vim.g.vimtex_view_method='skim' 
vim.g.vimtex_view_method='zathura'

-- skim options:
-- Set Skim sync options to:
--
-- DO NOT check any of the checkboxes
--
-- Preset: Custom
-- Command: nvr
-- Arguments: --remote +"%line" "%file"

vim.g.vimtex_quickfix_mode=2 -- default value

-- tex conceal: accents/ligatures, bold and italic, delimiters, math symbols, Greek
vim.g.tex_conceal='abdmg'

-- see: https://github.com/lervag/vimtex/issues/1576
-- FOR BACKWARD SEARCH WORK FROM SKIM (OR ANOTHER PDF VIEWER)
-- NEOVIM MUST BE INVOKED WITH:
-- NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim file.tex
vim.g.vimtex_compiler_progname = 'nvr'

-- TODO: autocmd for enable a specific neovim socket for when editing LaTeX
-- and seeing them with Skim pdf viewer
-- also  see: https://jdhao.github.io/2021/02/20/inverse_search_setup_neovim_vimtex/
-- relevant too: https://github.com/neovim/neovim/issues/1750

-- vim.g.vimtex_view_automatic = 0

-- setup Vim Digraphs and Ligatures
-- TODO: https://alpha2phi.medium.com/vim-digraphs-and-ligatures-7dec3cb0a623
