" Hugo

" Taken from: https://discourse.gohugo.io/t/vim-syntax-highlighting-for-hugo-html-templates/19398/10"

" Useful for hugo, because it DOES NOT allow custom extensions as templates,
" such as .tmpl
" See: https://github.com/gohugoio/hugo/issues/3230

" TODO: convert to lua

" If go html template is detected, set filetype to gohtmltmpl from faith/vim-go plugin
function DetectGoHtmlTmpl()
    if expand('%:e') ==# 'html' && search('{{') != 0
        " syntax/indent/ftplugin files comes from faith/vim-go plugin
        set filetype=gohtmltmpl
    endif
endfunction

augroup filetypedetect
    au! BufRead,BufNewFile * call DetectGoHtmlTmpl()
augroup END
