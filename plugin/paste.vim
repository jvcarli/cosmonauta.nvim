" SEE: taken from: https://gist.github.com/romainl/1cad2606f7b00088dda3bb511af50d53
"                  https://fernandobasso.dev/shell/copy-paste-from-command-line-xclip-xsel-clipboard.html
"                  https://stackoverflow.com/questions/2575545/vim-pipe-selected-text-to-shell-cmd-and-receive-output-on-vim-info-command-line

" SEE: also https://github.com/habamax/.vim/blob/master/autoload/share.vim

" TODO: convert it to lua

" Linux and other UNIX-like systems (excluding macos) requires curl and xsel or xclip
" -----------------------------------------------------------
" For getting the url into the clipboard:
"   if using xclip use: xclip -i -selection clipboard
"   if using xsel use: xsel --clipboard
"   if using pbcopy use: pbcopy

if has('macunix')
    " use macos default pbcopy app for copying cotent into the system clipboard
    let s:copy_to_system_clipboard_cmd = 'pbcopy'
else
    " will work on linux, what is linux defaults (if that exists) for clipboard?
    " It works under X11 and Wayland, but I think that it uses XWayland under
    " the hood when using Wayland. TODO: find out and use a proper wayland
    " clipboard if that happens.
    let s:copy_to_system_clipboard_cmd = 'xsel --clipboard'
    " TODO: make work on Windows too
endif

function IxPasteBin() range
    let filetype = &filetype
    let get_range = join(getline(a:firstline, a:lastline), "\n")

    " TODO: external_command is hard to read, try to make it cleaner.

    " Send text range to http://ix.io and copy the generated ix.io link to the system clipboard
    " Since the text was copied to the clipboard it will available on the system clipboard register too
    " awk command taken from: https://serverfault.com/questions/391360/remove-line-break-using-awk
    let external_command = "curl -F 'f:1=<-' http://ix.io | awk '{printf \"%s/" . &filetype .   "\",$0} END {print \"\"}' | tr -d '\n' | " . s:copy_to_system_clipboard_cmd

    " Assign the content of system clipboard (it will be the generated ix.io link) to w register
    let @w=@+

    " TODO: if filetype is unusual filetypes such as typescriptreact, do something?
    echo 'Pasting selection into http://ix.io ...'

    silent echo system(external_command, get_range)

    echo 'Finished!'
endfunction

command! -range=% -nargs=0 IX <line1>,<line2> call IxPasteBin()

" All commands below are working, but I'm only using http://ix.io service

" command! -range=% CL <line1>,<line2>w !curl -F 'clbin=<-' https://clbin.com | tr -d '\n' | xclip -i -selection clipboard
" command! -range=% VP <line1>,<line2>w !curl -F 'text=<-' http://vpaste.net | tr -d '\n' | xclip -i -selection clipboard
" command! -range=% EN <line1>,<line2>w !curl -F 'file=@-;' https://envs.sh | tr -d '\n' | xclip -i -selection clipboard
"
" requires netcat (on arch install it with: sudo pacman -S gnu-netcat)
" command! -range=% TB <line1>,<line2>w !nc termbin.com 9999 | tr -d '\n' | xclip -i -selection clipboard
