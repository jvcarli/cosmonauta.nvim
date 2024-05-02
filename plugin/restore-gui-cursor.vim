" TODO: guard it for alacritty only, on Kitty it won't affect
"       but it is good to guard it anyways.
"       SEE: https://github.com/alacritty/alacritty/issues/2839
" WARN: it does mess with tmux too. Which honestly is good because
"       I don't know yet how to make it respect cursor preferences when
"       I start it
augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:ver25,a:blinkwait0,a:blinkon500,a:blinkoff500
augroup END
