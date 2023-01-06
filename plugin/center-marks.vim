" Go to marked item and center it (' and ` marks)
"
" adapted from: https://www.reddit.com/r/vim/comments/80vutj/how_to_center_screen_after_moving_to_a_mark/
"               https://stackoverflow.com/a/35828073

" TODO: convert to lua
" http://lua-users.org/wiki/RangeIterator
"
" ' mark
for c in range(char2nr('0'), char2nr('9')) + range(char2nr('a'), char2nr('z')) + range(char2nr('A'), char2nr('Z'))
    execute 'nnoremap ' "'" . nr2char(c) . " '" . nr2char(c) . 'zzzv'
endfor

" " mark
for c in range(char2nr('0'), char2nr('9')) + range(char2nr('a'), char2nr('z')) + range(char2nr('A'), char2nr('Z'))
    execute 'nnoremap ' '`' . nr2char(c) . ' `' . nr2char(c) . 'zzzv'
endfor
