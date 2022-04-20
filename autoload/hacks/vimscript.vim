" taken from: https://github.com/ruanyl/vim-gh-line/pull/20/files#diff-96a3cf1912494e1f40b17b83bb33d74bR87
" SEE: https://vi.stackexchange.com/a/17871/13792

" getScriptID returns the SID of the given scriptName in the current runtime
" of vim.  Lists all sourced scripts, finds the line that matches the
" given scriptName. Expects only one match. Then parses the line describing
" the given scriptName.
function hacks#vimscript#GetScriptID(scriptName)

    let l:allScripts = split(execute('scriptnames'), '\n')

    let l:matchingLine = ''
    for line in l:allScripts
        if line =~ a:scriptName
            " First time seeing a matching script.
            if l:matchingLine == ''
                let l:matchingLine = line
            else
                " Multiple matches of the scriptName. Unexpected
                throw 'Found ' . a:scriptName . ' multiple times in sourced scripts.'
            endif
        endif
    endfor
    if l:matchingLine == ''
        throw  'Could not find ' . a:scriptName . ' in sourced scripts'
    endif

    " The matching line looks like this:
    " 20: ~/src/ruanyl/vim-gh-line/plugin/vim-gh-line.vim
    " extract the first number before : and return it as the scriptID
    let l:matchingList = split(l:matchingLine)
    if len(l:matchingList) != 2
        throw 'Unexlected line in scriptnames: ' . l:matchingLine
    endif

    let l:firstEntry = l:matchingList[0]
    let l:rv =  substitute(l:firstEntry, ':', '', '')
    return l:rv
endfunction

" callWithSID gives us the ability to call script local functions in the
" plugin implementation. For implementation details see
" https://vi.stackexchange.com/a/17871/13792
function hacks#vimscript#CallWithSID(sid,funcName,...)
    let l:FuncRef = function('<SNR>' . a:sid . '_' . a:funcName)
    let l:rv = call(l:FuncRef, a:000)
    return l:rv
endfunc
