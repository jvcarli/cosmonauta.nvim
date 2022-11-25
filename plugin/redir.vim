" # Redirect the output of a Vim or external command into a scratch buffer
"   taken from: https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7

" ## Usage (any shell)
" 
" Show full output of command `:hi` in scratch window:
" 
"     :Redir hi
" 
" Show full output of command `:!ls -al` in scratch window:
" 
"     :Redir !ls -al 
" 
" ## Additional usage (depends on non-standard shell features so YMMV)
" 
" Evaluate current line with `node` and show full output in scratch window:
" 
"     " current line
"     console.log(Math.random());
"     
"     " Ex command
"     :.Redir !node
" 
"     " scratch window
"     0.03987581000754448
" 
" Evaluate visual selection + positional parameters with `bash` and show full output in scratch window:
" 
"     " content of buffer
"     echo ${1}
"     echo ${2}
" 
"     " Ex command
"     :%Redir !bash -s foo bar
" 
"     " scratch window
"     foo
"     bar

function! Redir(cmd, rng, start, end)
	for win in range(1, winnr('$'))
		if getwinvar(win, 'scratch')
			execute win . 'windo close'
		endif
	endfor
	if a:cmd =~ '^!'
		let cmd = a:cmd =~' %'
			\ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
			\ : matchstr(a:cmd, '^!\zs.*')
		if a:rng == 0
			let output = systemlist(cmd)
		else
			let joined_lines = join(getline(a:start, a:end), '\n')
			let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
			let output = systemlist(cmd . " <<< $" . cleaned_lines)
		endif
	else
		redir => output
		execute a:cmd
		redir END
		let output = split(output, "\n")
	endif
	vnew
	let w:scratch = 1
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, output)
endfunction

command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)
