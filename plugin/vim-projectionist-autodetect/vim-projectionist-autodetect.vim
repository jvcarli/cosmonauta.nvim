" see: https://stackoverflow.com/questions/11822833/check-if-a-file-includes-some-content
" see: https://github.com/tpope/vim-projectionist/issues/73
" see: https://subvisual.com/blog/posts/133-super-powered-vim-part-i-projections/

" If project has package.json file and package.json has nextjs package
" TODO: filereadable MUST search across the project for the cwd (use .git dir?)
" BUG: this conditional will fail if neovim isn't started from the project root

" For now start the editor from the project root
if !empty(findfile('package.json', getcwd().';')) && match(readfile('package.json'),'next')!=-1
    " This looks like a NextJS app.
    augroup DefineProjectProjections
        au!
        " TODO: Remove hardcode expand path in readfile()
        au User ProjectionistDetect
            \ call projectionist#append(getcwd(),json_decode(join(readfile(expand('~/.config/nvim/plugin/vim-projectionist-autodetect/projections/projections-nextjs.json')))))
    augroup END
endif

" TODO: add projections and conditions for create react app, and hugo projects.
" TODO: make this a proper vimscript plugin
