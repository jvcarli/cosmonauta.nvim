""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                              "
"                         Minimal init.vim                     "
"                          Template file                       "
"                                                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

" TODO: recreate the template file on the fly
" using L3MON4D3/LuaSnip plugin

" Usage: {{{
"        Copy this file and then update accordingly.
"        Call your minimal init.vim using:
"          $ nvim -u <your_minimal_init.vim> 
"
"          -u vimrc    Use vimrc instead of the default
"                      ~/.config/nvim/init.vim.  If vimrc is
"                      NORC, do not load any initialization
"                      files (except plugins).  If vimrc is
"                      NONE, loading plugins is also skipped.
"                      :help initialization
" }}}

" vim-plug managed plugins directory
let vim_plug_plugins_dir = stdpath('data') . '/test/plugin' 

" vim-plug itself
let vim_plug_file  = stdpath('data') . '/test/autoload/plug.vim' 

" {{{ Install vim-plug plugin if it isn't already installed

if empty(glob(vim_plug_file))
  echo 'Installing vim-plug plugin manager...'
  silent execute '!curl -fLo '.vim_plug_file.' --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  echo 'Finished!'
endif
" }}}

" Minimal runtimepath and packpath {{{

set runtimepath='/etc/xdg/nvim,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/share/nvim/runtime,/usr/share/nvim/runtime/pack/dist/opt/matchit,/usr/lib/nvim,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/etc/xdg/nvim/after,'
set runtimepath+=~/.local/share/nvim/test " vim-plug managed plugins

set packpath='' " Remove packpath (~/.local/share/nvim/site/*)
" let &packpath='' " works too

" }}}

" {{{ Install missing plugins when entering Neovim
augroup InstallMissingPlugins
    autocmd VimEnter *
    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \|   PlugInstall --sync | q
    \| endif
augroup END
" }}}

" {{{ vim-plug comments
" Install vim-plug plugin manager (https://github.com/junegunn/vim-plug).
" packer.nvim is annoying for this because of
" its unreliable bootstrap process.
" vim-plug is a good option because it doesn't clash
" with packer plugins nor adds startup time when isn't being used.

" The default plugin directory will be as follows:
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.nvim/testing/yourplugin')`
"   - Don't use standard Vim directory names like 'plugin'
"   - as the the files there could clash between each other.
" }}}

if isdirectory(vim_plug_plugins_dir)
  echo 'Making a clean test environment...'
  call delete(vim_plug_plugins_dir, 'rf')
else
  echo 'Starting a clean test environment...'
endif

call plug#begin(vim_plug_plugins_dir)
" Place your desired plugins here

" Shorthand notation:
" Plug 'junegunn/vim-easy-align'
"
" Any valid git URL is allowed:
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
" Unmanaged plugin (manually installed and updated):
" Plug '~/my-prototype-plugin'

call plug#end()

" vim:fileencoding=utf-8:foldmethod=marker
