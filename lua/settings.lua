-- TODO: add more info about this option
-- nvim-compe prerequisite: "menuone,noselect"
vim.o.completeopt = "menuone,noselect"

-- in vim script: set termguicolors
-- TODO: list plugins that require this option
vim.o.termguicolors = true

-- Enable mouse scrolling in vim while in tmux
-- This will disable numbers selection when selecting
-- text with the mouse too
-- See: https://superuser.com/questions/610114/tmux-enable-mouse-scrolling-in-vim-instead-of-history-buffer
-- See: https://vim.fandom.com/wiki/Using_the_mouse_for_Vim_in_an_xterm
vim.o.mouse = "a"

-- Enable access to system clipboard with +y operator
-- see: https://advancedweb.hu/working-with-the-system-clipboard-in-vim/
-- Set the + register as the default: :set clipboard=unnamedplus.
-- Now every time you press y or p, Vim will use the system clipboard.
-- Yank to the system clipboard explicitly only when you need it with "+y, and paste from it with "+p.
-- TODO: integrate yanking with kitty private copy_paste buffer
vim.o.clipboard = "unnamedplus"

-- Numbers
-- equivalent to vimscript `set number relativenumber`
vim.wo.number = true
vim.wo.relativenumber = true

-- TODO: configure `wrapscan` option
-- When the search reaches the end of the file it will continue
-- at the start, unless the 'wrapscan' option has been reset.

-- Avoid annoying "ping-pong" of gitsigns, markers and so on on sign column:
-- for more options see: help s'signcolumn'
-- also see: https://www.reddit.com/r/neovim/comments/f04fao/my_biggest_vimneovim_wish_single_width_sign_column/
vim.wo.signcolumn = "yes:2"

-- conceal
-- Each block of concealed text is replaced with one
-- character.  If the syntax item does not have a custom
-- replacement character defined (see |:syn-cchar|) the
-- character defined in 'listchars' is used.
vim.wo.conceallevel=1

vim.wo.listchars =
    table.concat(
    {
        "eol:↴", -- TODO: see how it works
        -- "tab:│⋅",
        "space:⋅" -- how (null) space charcter is displayed
    },
    ","
)

vim.o.updatetime = 250 -- Decrease update time, so completion is faster

-- TODO: add relative number option (set relative number)
-- HACK: for this to work neovim MUST be patched manually
-- with number being aligned to the left
-- problem: this part of vim and neovim's code is hardcoded
-- see: https://vi.stackexchange.com/questions/3516/current-line-number-aligned-to-the-left-with-number-and-relativenumber
-- see: https://github.com/vim/vim/pull/2204
-- see: https://github.com/vim/vim/issues/1875
