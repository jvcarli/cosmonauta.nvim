" Using init.vim because this file is shared between Vim and Neovim
" The intention of this config is to see how far Vim/Nvim can go
" without plugins.

" Quickly switch between opened buffers
nnoremap ,b :ls<CR>:b<Space>

set ignorecase
set smartcase

" Set the window to have the value of 'titlestring'
" Good for using multiple terminal windows
" and to switch to them using an app like Contexts on macos
" or Rofi on Linux.
set title
