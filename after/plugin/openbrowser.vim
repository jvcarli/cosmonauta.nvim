" SEE: Inspired from: https://idie.ru/posts/vim-modern-cpp/#browsing-online-documentation-from-vim
let g:openbrowser_search_engines = extend(
            \ get(g:, 'openbrowser_search_engines', {}),
            \ {
            \   'cppreference': 'https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search={query}',
            \   'grep.app': 'https://grep.app/search?q={query}',
            \   'qt': 'https://doc.qt.io/qt-5/search-results.html?q={query}',
            \ },
            \ 'keep'
            \)
