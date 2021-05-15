" vim:fileencoding=utf-8:ft=vim:foldmethod=marker

lua << EOF

-- {{{ Python hosts
-- See: help host_prog
-- See: help python-virtualenv
-- See: https://github.com/neovim/pynvim
-- python2
-- used by: vimtex and skim (displaying compiled tex docs)
-- TODO: link it to a python2 venv and not to the global asdf python2 install
-- pip install pynvim
vim.g.python_host_prog = "~/.asdf/installs/python/2.7.18/bin/python"

-- python3
-- TODO: include which apps need python3 and python2
-- used by (don't remember because i didn't take notes)
-- pip install pynvim
vim.g.python3_host_prog = '~/.local/share/nvim/nvim-hardcoded-pythons/py3nvim/venv/bin/python'
-- }}}

-- Packer plugin config file 
-- when possible / convenient plugin configuration is declared there
require('plugins')

-- Neovim vanilla settings
require('settings')

-- Color themes
require('themes')

-- LSP (langauge server protocol) configuration
require('lsp')

-- Keymappings
require('keymappings')

-- Dap (debug adaptor protocol) configuration
-- require('dap')

-- python debuger
-- debugpy MUST be installed inside dap-python venv: `pip install debugpy` inside it
-- See: https://github.com/mfussenegger/nvim-dap-python
-- FIX: bugfix, for some reson dap-python doesn't work when not called directly from init.vim
require'dap-python'.setup('~/.local/share/nvim/nvim-lsp-debug-adaptors/debugpy/venv/bin/python')

-- Legacy section (vimscrit being used by lua)
-- autocmds
-- legacy/autocms and legacy/augroups section are coded with vimscript
-- because augroups and autocommands DO NOT have an interface yet,
-- but is being worked on, see: https://github.com/neovim/neovim/pull/12378
--
-- There is no equivalent to the :set command in Lua, you either set an option
-- globally or locally. If you're setting options from your init.lua,
-- some of them will require you to set both vim.o.{option} and vim.{wo/bo}.{option} to work properly.
-- see: https://github.com/nanotee/nvim-lua-guide#caveats-3
-- see: https://github.com/neovim/neovim/pull/13479
require('legacy/autocmds')
require('legacy/augroups')

EOF

" TODO: Setup neovim lua plugin development env:
" see:https://gist.github.com/folke/fe5d28423ea5380929c3f7ce674c41d8

" {{{ vimscript

" {{{ Tabs, spaces, splits and panes configuration

" General: use tab equals 4 spaces, and expand tabs as spaces
set tabstop=4 " show <tab> charcter as 4 spaces
set shiftwidth=4
set softtabstop=4
set expandtab

" nvim panes
" open new split panes to right and below
set splitright
set splitbelow

" }}}

" {{{ nvim terminal

" uses zsh instead of bash
"function! OpenTerminal()
"  split term://zsh
"  " zsh terminal column size
"  resize 10
"endfunction
"
"" open terminal on ctrl+n
"" nnoremap <c-n> :call OpenTerminal()<CR>
"nnoremap <leader>t :call OpenTerminal()<CR>
"
"" start terminal in insert mode
"au BufEnter * if &buftype == 'terminal' | :startinsert | endif
"
"" turn terminal to normal mode with escape
"tnoremap <Esc> <C-\><C-n>
"
"" }}}

" {{{ Leader key change
" map space to leader key
" See: https://stackoverflow.com/questions/25341062/vim-let-mapleader-space-annoying-cursor-movement
nmap <space> <leader>
" }}}

" Plugins:
" {{{ vim-telescope
" Using lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>ft <cmd>lua require('telescope.builtin').treesitter()<CR>
" }}}

" nvim-dap-python {{{
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dd :lua require('dap').continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.repl.run_last()<CR>`
nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
" }}}

" TODO: move this shortcut to keymappings/init.lua

" {{{ vimtex
" see: https://castel.dev/post/lecture-notes-1/#vim-and-latex
" FIX: why can't this be set in plugins.lua conf like other plugins
" on macOS  install required latex packages with:
" brew install --cask mactex-no-gui

let g:tex_flavor='latex'

" skim is a macos only program
" zathura can be used on linux,
" other options such as macos built in previewer
" other apps can be used too
let g:vimtex_view_method='skim' 

" skim options:
" Set Skim sync options to:
"
" DO NOT check any of the checkboxes
"
" Preset: Custom
" Command: nvr
" Arguments: --remote +"%line" "%file"

let g:vimtex_quickfix_mode=2 " default value

" conceal: accents/ligatures, bold and italic, delimiters, math symbols, Greek
let g:tex_conceal='abdmg'

" see: https://github.com/lervag/vimtex/issues/1576
" FOR BACKWARD SEARCH WORK FROM SKIM (OR ANOTHER PDF VIEWER)
" NEOVIM MUST BE INVOKED WITH:
" NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim file.tex
let g:vimtex_compiler_progname = 'nvr'

" TODO: autocmd for enable a specific neovim socket for when editing LaTeX
" and seeing them with Skim pdf viewer
" also  see: https://jdhao.github.io/2021/02/20/inverse_search_setup_neovim_vimtex/
" relevant too: https://github.com/neovim/neovim/issues/1750

" from the docs
let g:vimtex_view_automatic = 0

" }}}

" }}}

