" Taken from: https://www.reddit.com/r/vim/comments/foeo5k/vimcamelsnek_quickly_convert_between_camelcase/
" TODO: convert to lua
let g:caser_no_mappings = 1

nmap <expr> gsc caser_settings#choose_case(0)
xmap <expr> gsc caser_settings#choose_case(1)

function! caser_settings#choose_case(visual)
  let l:options = [
        \ '&MixedCase',
        \ '&camelCase',
        \ 'snake&_case',
        \ '&UPPER_CASE',
        \ '&Title Case',
        \ '&Sentence case',
        \ 'space& case',
        \ 'kebab&-case',
        \ 'dot&.case']
  let l:choice = confirm('Change case?', join(l:options, "\n"))
  let l:operation = [
        \ 'MixedCase',
        \ 'CamelCase',
        \ 'SnakeCase',
        \ 'UpperCase',
        \ 'TitleCase',
        \ 'SentenceCase',
        \ 'SpaceCase',
        \ 'KebabCase',
        \ 'DotCase'][l:choice - 1]
  if a:visual
    return "\<Plug>CaserV".l:operation
  else
    return "\<Plug>Caser".l:operation
  end
endfunction
