" for reference
" cnoreabbrev <expr> linedifflast  (getcmdtype() == ":" && getcmdline() ==# "'<,'>LinediffLast")  ? 'LinediffLast'  : 'linedifflast'
" SEE: https://vi.stackexchange.com/questions/33220/make-cabbrev-work-from-command-line-but-not-search-prompt
" SEE: https://www.youtube.com/watch?v=fmooSAni8cM

" is not working fully:
" function! CnoreabbrevStrReplace(str_to_replace)
"     if getcmdtype() ==# ':'
"         " when command-line starts with the string to replace
"         " (on visual mode or not)
"         if getcmdline() ==? (a:str_to_replace || "'<,'>" . a:str_to_replace)
"             " SEE: https://stackoverflow.com/questions/39621991/change-title-case-the-first-letters-of-all-words-capitalized-in-vim
"             " capitalize first letter of the string to replace
"             let result = substitute(a:str_to_replace,'\(\<\w\+\>\)', '\u\1', 'g')
"             return result
"         else
"             " result is the string to replace itself
"             return a:str_to_replace
"         endif
"     else
"         " all other command-line types
"         " result is the string to replace itself
"         return a:str_to_replace
"     endif
" endfunction

" Vanilla Neovim

" SEE: https://github.com/kana/vim-altercmd
"      Vim plugin: Alter built-in Ex commands by your own ones
"      It leverages builtin abbrevs

" Make :H ONLY open help pages on a new tab
" lower case h is needed, :h will have the default behavior
" inspired from: https://github.com/vim-utils/vim-man
command! -nargs=1 -complete=help H tab h <args>
command! -nargs=1 M tab Man <args>

" fugitive.vim
cnoreabbrev <expr> gb getcmdtype() == ":" && getcmdline() == 'gb' ? 'Git blame' : 'gb'
cnoreabbrev <expr> gc getcmdtype() == ":" && getcmdline() == 'gc' ? 'Git commit -v' : 'gc'


" linediff.vim
" TODO: include reddit answer
cnoreabbrev <expr> linediff (getcmdtype() == ':' && getcmdline() =~# '^\(''<,''>\)\?linediff$') ? 'Linediff' : 'linediff'
" works too:
" cnoreabbrev <expr> linediff  CnoreabbrevStrReplace('linediff')
" cnoreabbrev <expr> linediffpick  CnoreabbrevStrReplace('linediffpick')
" cnoreabbrev <expr> linediffshow  CnoreabbrevStrReplace('linediffshow')
" cnoreabbrev <expr> linediffmerge CnoreabbrevStrReplace('linediffmerge')
" cnoreabbrev <expr> linediffreset CnoreabbrevStrReplace('linediffreset')

" netrw
" cnoreabbrev <expr> E getcmdtype() == ":" && getcmdline() == 'E' ? 'Explore' : 'E'
