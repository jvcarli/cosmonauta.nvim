" Taken from: https://thoughtbot.com/blog/wrap-existing-text-at-80-characters-in-vim
" Automatically wrap at 80 characters
" https://prettier.io/docs/en/options.html

" Follows Prettier Markdown default line wrapping:
" Lines can be select in visual mode and formated using `gq` "
" See: h: gq
setlocal textwidth=80

" Follows prettier default tab/space behavior
set tabstop=2 " show <tab> character as 2 spaces
set shiftwidth=2
set softtabstop=2
set expandtab
