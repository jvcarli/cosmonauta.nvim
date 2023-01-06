" SEE: taken from: https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3

" TODO: convert it to lua and make it async
"       SEE: https://teukka.tech/posts/2020-01-07-vimloop/

" SEE: `:h expand` for smart grep arguments based on vim expansions
"      e.g. `:Grep -w smart` searches for the word `smart` starting from your cwd,
"            -w is passed to grepprg, which in this case is ripgrep `rg`
"            command.
"      e.g. `"Grep -w smart %` searches for the word `smart` ONLY in your
"           current buffer because % gets expanded by VIM, not by grepprg.
"           -w is passed to grepprg as usual.

function! Grep(...)
    return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
augroup END
