" vim:fileencoding=utf-8:ft=vim:foldmethod=marker
" Neovim: following head -> for breaking changes, see: https://github.com/neovim/neovim/issues/14090"

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

-- Packer plugins
require('plugins')

-- Nvim native lsp
require('lsp')

-- Color themes
require('themes')

-- Keymappings
require('keymaps')

-- Dap (debug adapter protocol) configuration
-- languages: dap-python
-- TODO: install more debug-adapters
-- require('debug-adapters')

-- autocmd and augroups
require('autocmds')

-- TODO: Setup neovim lua plugin development env:
-- see: https://gist.github.com/folke/fe5d28423ea5380929c3f7ce674c41d8

EOF

" }}}

" {{{ vimscript

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
nnoremap <leader>to :call OpenTerminal()<CR>

" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
"
"" }}}

" {{{ Ide integration

" See: https://www.reddit.com/r/vim/comments/b2m2dp/move_from_ide_to_vim/
" See: https://stackoverflow.com/questions/4037984/is-it-possible-to-extend-intellij-such-that-i-can-open-the-current-file-in-vim
" See: https://vi.stackexchange.com/questions/18073/neovim-qt-is-it-possible-open-files-in-the-existing-window
" See: https://www.reddit.com/r/neovim/comments/nehuye/how_to_alternate_between_neovim_and_other_text/
" Opens Webstorm in the same line as nvim buffer. Column is not supported by
" webstorm cli.
nnoremap <leader>iw :execute 'silent !webstorm --line '.line('.').' '.expand('%:p')\|redraw!<cr>

" }}}

" {{{ Hugo
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
" }}}

" {{{ Lspsaga
nnoremap <silent><leader>clf :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>cca :Lspsaga code_action<CR>
vnoremap <silent><leader>cca :<C-U>Lspsaga range_code_action<CR>

nnoremap <silent><leader>chd :Lspsaga hover_doc<CR>
nnoremap <silent><C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent><C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

nnoremap <silent><leader>csh :Lspsaga signature_help<CR>

nnoremap <silent><leader>crn :Lspsaga rename<CR>

nnoremap <silent><leader>cpd :Lspsaga preview_definition<CR>

nnoremap <silent> <leader>cld :Lspsaga show_line_diagnostics<CR>

" nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
" nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>

nnoremap <silent> <leader>cot :Lspsaga open_floaterm<CR>
tnoremap <silent> <leader>cct <C-\><C-n>:Lspsaga close_floaterm<CR>

" }}}

" {{{ nvim-compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
" }}}

" {{{ nvim-tree
nnoremap <leader>n :NvimTreeToggle<CR>

let g:nvim_tree_side = 'left' "left by default
let g:nvim_tree_width = 35 "30 by default
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_gitignore = 1 "0 by default
let g:nvim_tree_auto_open = 1 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:nvim_tree_auto_close = 0 "0 by default, closes the tree when it's the last window
let g:nvim_tree_auto_ignore_ft = [ 'startify', 'dashboard' ] "empty by default, don't auto open tree on specific filetypes.
let g:nvim_tree_quit_on_open = 0 "0 by default, closes the tree when you open a file
let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open
let g:nvim_tree_width_allow_resize  = 1 "0 by default, will not resize the tree when opening a file
let g:nvim_tree_disable_netrw = 0 "1 by default, disables netrw
let g:nvim_tree_hijack_netrw = 0 "1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_lsp_diagnostics = 1 "0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
let g:nvim_tree_hijack_cursor = 0 "1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_update_cwd = 0 "1 by default, will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = [ 'README.md', 'Makefile', 'MAKEFILE' ] " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

" nnoremap <leader>r :NvimTreeRefresh<CR>
" nnoremap <leader>n :NvimTreeFindFile<CR>

" NvimTreeOpen and NvimTreeClose are also available if you need them

" a list of groups can be found at `:help nvim_tree_highlight`

" }}}

" {{{ Vista

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'nvim_lsp'

" }}}

" {{{ markdown-preview
" TODO: check markdown, txt and latex concealing

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" }}}

" {{{ Colortuner
" https://www.reddit.com/r/vim/comments/33cs9l/colortuner_a_small_plugin_to_tune_colorschemes/
" https://github.com/zefei/vim-colortuner

let g:colortuner_preferred_schemes = ['tokyonight', 'solarized']

let g:colortuner_vivid_mode = 0

let g:colortuner_filepath = '~/.local/share/nvim/vim-colortuner.json'

let g:colortuner_enabled = 1

" }}}

" }}}

" {{{ Time profilling

" See: https://stackoverflow.com/questions/12213597/how-to-see-which-plugins-are-making-vim-slow

" Neovim responsiveness:
" launch a file with nvim
" :profile start profile.log
" :profile func *
" :profile file *
" At this point do slow actions that you want to profile
" :profile pause
" :noautocmd qall!

" Packer plugins loading time
" launch nvim
" :PackerCompile profile = true
" quit nvim and launch it again
" :PackerProfile

" nvim --startuptime timeCost.log timeCost.log

" }}}

" TODO: what's the purpose of set re=0
" TODO: test persitant undo with undotree
" See: https://vi.stackexchange.com/questions/177/what-is-the-purpose-of-swap-files

" vim-illuminate
" hi LspReferenceRead cterm=bold ctermbg=237 guibg=#45403d

" hi LspReferenceText cterm=bold ctermbg=237 guibg=#45403d
" hi LspReferenceWrite cterm=bold ctermbg=237 guibg=#45403d

" let g:kitty_navigator_no_mappings = 1

" {{{ vim-kitty-navigator

"see: https://github.com/knubie/vim-kitty-navigator/issues/5

nnoremap <silent> <A-h> :KittyNavigateLeft<cr>
nnoremap <silent> <A-j> :KittyNavigateDown<cr>
nnoremap <silent> <A-k> :KittyNavigateUp<cr>
nnoremap <silent> <A-l> :KittyNavigateRight<cr>

" }}}

" TODO: for code lens info: https://github.com/neovim/neovim/pull/13165

" INDENT
" see: https://www.reddit.com/r/neovim/comments/nyjabl/absolutely_awful_indent/
" see: https://github.com/windwp/nvim-autopairs/issues/66
