" Hugo gohtmltmpl detection
" TODO: convert to lua?

" Taken from: https://discourse.gohugo.io/t/vim-syntax-highlighting-for-hugo-html-templates/19398/10"

" Useful for hugo, because it DOES NOT allow custom extensions as templates
" such as .tmpl yet.
" SEE: https://github.com/gohugoio/hugo/issues/3230

" If go html template is detected, set filetype to gohtmltmpl
function DetectGoHtmlTmpl()
    if search('{{') != 0
        " syntax/indent/ftplugin files comes from faith/vim-go plugin
        set filetype=gohtmltmpl
    endif
endfunction

" NOTE: should NOT use augroup in ftdetect
" SEE: `:help ftdetect` and https://www.reddit.com/r/neovim/comments/skac4h/lsp_working_after_e/
au BufRead,BufNewFile *.html call DetectGoHtmlTmpl()
