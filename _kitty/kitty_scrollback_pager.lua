-- Minimal Neovim init file so Neovim opens really fast when used as a kitty scrollback buffer.

-- This configuration file is invoked from scrollback-buffer shortcut defined
-- in ~/.config/kitty/kitty.conf
-- SEE: https://sw.kovidgoyal.net/kitty/overview/#the-scrollback-buffer
-- SEE: kitty config file: ~/.config/kitty/kitty.conf

vim.opt.runtimepath = "$VIMRUNTIME"
vim.opt.packpath = ""

--Show line numbers
vim.opt.number = true

--Disable numbers selection when selecting text with the mouse
vim.o.mouse = "a"

-- Use the OS clipboard for copy and pasting
-- TODO: unnamed or unnamedplus? remember there's linux too
vim.o.clipboard = "unnamed"

-- Plays nice when there's multiple scrollback buffers opened
-- NOTE: there can't be a swapfile because if Kitty tries to
--       access the /tmp/tmp_buffer it creates for the scrollback buffer
--       it will fail.
vim.opt.swapfile = false

vim.o.termguicolors = true

-- Maps q and escape keys for existing vim in NORMAL mode
vim.keymap.set("n", "q", "<cmd>q!<CR>")
vim.keymap.set("n", "<ESC>", "<cmd>:q!<CR>")

-- TODO: lua function that goes to the last non whitespace char of the current buffer
-- SEE: https://stackoverflow.com/questions/33663205/vim-jump-to-last-non-whitespace-character-of-a-file
--
-- in viml
-- " Go to the last non whitespace char
-- " SEE: https://stackoverflow.com/questions/33663205/vim-jump-to-last-non-whitespace-character-of-a-file
--
-- function! LastChar()
--     let oldsearch = @/
--     let oldhls = &hlsearch
--     let oldz = @z
--
--     normal G$"zyl
--     if match(@z, '\S')
--         exe "norm ?\\S\<CR>"
--     endif
--
--     let @/ = oldsearch
--     let &hlsearch = oldhls
--     let @z = oldz
-- endfunction
--
-- command! LC call LastChar()
--
-- Other try:
--
--
-- function! LastChar()
--     execute 'normal! G'
--     call search('^.\+', 'b')
-- endfunction

-- TODO: insert autocommand to evoke LastChar function and then
-- TODO: place the line to the bottom of the screen (zb)
-- SEE: https://unix.stackexchange.com/questions/110251/how-to-put-current-line-at-top-center-bottom-of-screen-in-vim
--

-- TODO: add plugins: colorscheme
--                    leap.nvim
--                    vim-wordmotion

-- TODO: set virtualedit to all

-- augroup UpdateCursorPosition
--     autocmd!
--     autocmd VimEnter * call execute('normal! ?.')
--     " autocmd VimEnter * call search('^.\+', 'b')
-- augroup END
