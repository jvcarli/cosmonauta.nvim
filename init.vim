" vim:fileencoding=utf-8:ft=vim:foldmethod=marker

" Lua {{{

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
-- dap-python, ... TODO: install more debug-adaptors
require('debug-adaptors')

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

-- TODO: Setup neovim lua plugin development env:
-- see: https://gist.github.com/folke/fe5d28423ea5380929c3f7ce674c41d8

EOF

" }}}

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
function! OpenTerminal()
  split term://zsh

  " remove numbers
  set nonumber
  set norelativenumber

  " zsh terminal column size
  resize 8 

endfunction

" open terminal on ctrl+n
" nnoremap <c-n> :call OpenTerminal()<CR>
nnoremap <leader>te :call OpenTerminal()<CR>

" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
"
"" }}}

" {{{ Leader key change
" map space to leader key
" See: https://stackoverflow.com/questions/25341062/vim-let-mapleader-space-annoying-cursor-movement
" See: https://stackoverflow.com/questions/446269/can-i-use-space-as-mapleader-in-vim
" nnoremap does not work
nmap <space> <leader>

" }}}

" }}}

" See: https://www.reddit.com/r/vim/comments/b2m2dp/move_from_ide_to_vim/
" See: https://stackoverflow.com/questions/4037984/is-it-possible-to-extend-intellij-such-that-i-can-open-the-current-file-in-vim
" See: https://www.reddit.com/r/neovim/comments/nehuye/how_to_alternate_between_neovim_and_other_text/
" Opens Webstorm in the same line as nvim buffer. Column is not support by
" webstorm cli.
nnoremap <leader>iw :execute 'silent !webstorm --line '.line('.').' '.expand('%:p')\|redraw!<cr>

