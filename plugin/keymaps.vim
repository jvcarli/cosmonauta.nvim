" Some awesome mappings from other people:
" SEE: http://andrewradev.com/2011/04/26/my-vim-workflow-basic-moves/
" SEE: https://www.reddit.com/r/vim/comments/8k4p6v/what_are_your_best_mappings/

" Opens line below or above the current line
"   <S-CR> is seems as the same as <CR> on alacrity, kitty and wezterm
"   THIS IS NOT A BUG, you can define custom escape codes for them to work
"
"   NOTE: <S-CR> and <C-CR> mappings only work when adding especial escape codes
"         to terminals that have this capabilities (e.g. modern terminals: kitty, alacritty, wezterm, etc)
"         Unicode, Escape codes and all that niche stuff:
"         SEE: http://www.leonerd.org.uk/hacks/fixterms/
"         SEE: https://github.com/kovidgoyal/kitty/issues/47
"         SEE: https://github.com/kovidgoyal/kitty/issues/498
"         SEE: https://www.youtube.com/watch?v=lHBD6pdJ-Ng
"         SEE: https://www.reddit.com/r/neovim/comments/vfqseq/enable_special_keyboard_combinations_in_alacritty/
"         SEE: https://github.com/alexherbo2/alacritty-extended-keys
"
" Don't break line and go line up in insert mode:
inoremap <S-CR> <C-O>o
" Don't break line and go line down in insert mode (a lot of messaging apps and
" other GUI apps have this heavior):
inoremap <C-CR> <C-O>O

" better manual scrolling
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>

" For moving quickly up and down,
" Goes to the first line above/below that isn't whitespace
" SEE: http://vi.stackexchange.com/a/213
" TODO: explore https://github.com/inkarkat/vim-JumpToVerticalOccurrence
"       that I think it is like this mapping but way better.
nnoremap <silent> gj :let _=&lazyredraw<CR>:set lazyredraw<CR>/\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>
nnoremap <silent> gk :let _=&lazyredraw<CR>:set lazyredraw<CR>?\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>
vnoremap <silent> gj :let _=&lazyredraw<CR>:set lazyredraw<CR>/\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>
vnoremap <silent> gk :let _=&lazyredraw<CR>:set lazyredraw<CR>?\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>

" TODO:
" easily to reach mappings that are not used by default:
" nnoremap cu
" nnoremap cd

" cd vim into the directory of the current file, menumonic is cd(file)
nnoremap <silent> cdf :cd %:p:h<CR>
" cd into the git repo, mneumonic is cdg(it)
nnoremap <silent> cdg :Gcd<CR>

" TODO: cd into the bare git repo root, mneumonic is cdb(are)
" nnoremap cdb <lua function>

" IDEA: Change the working directory for everybody
" nnoremap <leader>cd :windo lcd

" Break bad habits
" When I hold 'd' letter it acts as a modifier.
" When hold and pressed with hjkl (i.e. hold D and press h,j,k or l) it acts as arrow keys.
" for apps that don't support vim-like keybindings. This cause me sometimes to
" use it inside insert mode when using Neovim and I don't want that.
inoremap <Up>     <C-o>:echom "--> k <-- "<CR>
inoremap <Down>   <C-o>:echom "--> j <-- "<CR>
inoremap <Right>  <C-o>:echom "--> l <-- "<CR>
inoremap <Left>   <C-o>:echom "--> h <-- "<CR>

" TODO: neovim terminal keybindgs that don't suck
"
" terminal remaps for zsh-vi-mode
" escape to nvim normal mode
" tnoremap <Esc> <C-\\><C-n>
"
" escape to <Esc> which will go to zsh-vi-mode
"
" tnoremap <C-\\> <Esc>
"
"
" if has('nvim')
"     " Make esc leave terminal mode
"     tnoremap <leader><Esc> <C-\><C-n>
"     tnoremap <Esc><Esc> <C-\><C-n>
"
"     " Easy moving between the buffers
"     tnoremap <A-h> <C-\><C-n><C-w>h
"     tnoremap <A-j> <C-\><C-n><C-w>j
"     tnoremap <A-k> <C-\><C-n><C-w>k
"     tnoremap <A-l> <C-\><C-n><C-w>l
"
"     " Try and make sure to not mangle space items
"     tnoremap <S-Space> <Space>
"     tnoremap <C-Space> <Space>
" endif
"

" TODO: explore the black hole register:
"
"
" Helpful delete/change into blackhole buffer
" nmap <leader>d "_d
" nmap <leader>c "_c
" nmap <space>d "_d
" nmap <space>c "_c

" NOTE: really cool
" Change the replace word in insertmode (NON LSP, using vim regexp)
" Change the replace word in insertmode.
" Auto places you into the spot where you can start typing to change it.
nnoremap <c-w><c-r> :%s/<c-r><c-w>//g<left><left>

" TODO: remember cursor position function when invoking dial-increment just
" like vim-yankstack
nmap  <C-a>   <Plug>(dial-increment)
nmap  <C-x>   <Plug>(dial-decrement)
vmap  <C-a>   <Plug>(dial-increment)
vmap  <C-x>   <Plug>(dial-decrement)
vmap  g<C-a> g<Plug>(dial-increment)
vmap  g<C-x> g<Plug>(dial-decrement)

" SEE: taken from https://stackoverflow.com/questions/2005214/switching-to-a-particular-tab-in-vim
" Jump to particular tab directly
"NORMAL mode bindings for gvim
noremap <unique> <A-1> 1gt
noremap <unique> <A-2> 2gt
noremap <unique> <A-3> 3gt
noremap <unique> <A-4> 4gt
noremap <unique> <A-5> 5gt
noremap <unique> <A-6> 6gt
noremap <unique> <A-7> 7gt
noremap <unique> <A-8> 8gt
noremap <unique> <A-9> 9gt
noremap <unique> <A-0> 10gt
noremap <unique>  <A-t> :tabnew<CR>
noremap <unique>  <A-w> :tabclose<CR>

"INSERT mode bindings for gvim
inoremap <unique> <A-1> <C-O>1gt
inoremap <unique> <A-2> <C-O>2gt
inoremap <unique> <A-3> <C-O>3gt
inoremap <unique> <A-4> <C-O>4gt
inoremap <unique> <A-5> <C-O>5gt
inoremap <unique> <A-6> <C-O>6gt
inoremap <unique> <A-7> <C-O>7gt
inoremap <unique> <A-8> <C-O>8gt
inoremap <unique> <A-9> <C-O>9gt
inoremap <unique> <A-0> <C-O>10gt
inoremap <unique>  <A-t> :tabnew<CR>
inoremap <unique>  <A-w> :tabclose<CR>
