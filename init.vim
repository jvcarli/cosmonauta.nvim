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

-- Neovim vanilla settings
require('settings')

-- Packer plugin config file 
-- when possible / convenient plugin configuration is declared there
require('plugins')


-- Color themes
require('themes')

-- Keymappings
require('keymaps')

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
" See: https://vi.stackexchange.com/questions/18073/neovim-qt-is-it-possible-open-files-in-the-existing-window
" See: https://www.reddit.com/r/neovim/comments/nehuye/how_to_alternate_between_neovim_and_other_text/
" Opens Webstorm in the same line as nvim buffer. Column is not support by
" webstorm cli.
nnoremap <leader>iw :execute 'silent !webstorm --line '.line('.').' '.expand('%:p')\|redraw!<cr>

" {{{ vim tex
" see: https://castel.dev/post/lecture-notes-1/#vim-and-latex
" FIX: why can't this be set in plugins.lua conf like other plugins
" on macOS  install required latex packages with:
" brew install --cask mactex-no-gui
let g:tex_flavor='latex'

" skim is a macos only program
" zathura can be used on linux,
" other options such as macos built in previewer
" other apps can be used too
" let g:vimtex_view_method='skim' 
let g:vimtex_view_method='zathura'

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

"let g:vimtex_view_automatic = 0

" }}}

" If go html template is detected, set filetype to gohtmltmpl from
" faith/vim-go plugin
" see: https://discourse.gohugo.io/t/vim-syntax-highlighting-for-hugo-html-templates/19398/10"
" Usefull for hugo, because it DOES NOT allow custom extensions as templates,
" see: https://github.com/gohugoio/hugo/issues/3230
function DetectGoHtmlTmpl()
    if expand('%:e') == "html" && search("{{") != 0
        set filetype=gohtmltmpl 
    endif
endfunction

augroup filetypedetect
    au! BufRead,BufNewFile * call DetectGoHtmlTmpl()
augroup END

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" For syntax hightlighting working with go html templates
" gohtmltmpl filetype from faith/vim-go is used,
" Coc-prettier won't recognize this filetype, so a map
" to html is used. This preserver the syntax hightlighting
" and Coc-prettier formatting / autoformatting
" https://github.com/neoclide/coc-prettier/issues/71
let g:coc_filetype_map = {
    \ 'gohtmltmpl': 'html',
    \ }
