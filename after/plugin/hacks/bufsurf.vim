" HACK: One shouldn't access script functions theoretically ...
"       But sometimes the plugins don't have an API
"       Or don't expose its functions inside autoload
"       due to design decisions (or not).
" SEE: https://vi.stackexchange.com/questions/17866/are-script-local-functions-sfuncname-unit-testable

" Getting vim-bufsurf bufsurf.vim script id
" vim-bufsurf doesn't expose autoload function
" so we MUST its script local variables. s:<var-or-func> (Local to a script.)
" We do that by first getting its SID.
" SIDs number can change so we MUST get it in real time.
let s:BufSurfSID = hacks#vimscript#GetScriptID('vim-bufsurf/plugin/bufsurf.vim')

" Shorten function
function s:BufSurfClear()
  return hacks#vimscript#CallWithSID(s:BufSurfSID, 'BufSurfClear')
endfunction

" Override the autocommands that handle MRU buffer ordering per window.
augroup AdditionalBufSurfAutocmds
  autocmd!
  " TODO:
  " delelete entry from BufSurfList without messing up its order
  " autocmd BufDelete * call s:BufSurfDelete
  autocmd TabNewEntered * :call s:BufSurfClear()
augroup END
