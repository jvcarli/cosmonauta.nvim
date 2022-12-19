" taken from: https://gist.github.com/romainl/3b8cdc6c3748a363da07b1a625cfc666
" TODO: convert to lua
" TODO: Break the undo sequence in normal mode before using BreakHere()
"       SEE: https://vi.stackexchange.com/questions/27185/break-the-undo-sequence-in-normal-mode
"       SEE: :h :undojoin
function! BreakHere()
    s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
    call histdel("/", -1)
endfunction

nnoremap L :<C-u>call BreakHere()<CR>
