--=======================================--
--              About settings           --
--=======================================--
--
-- see: https://oroques.dev/notes/neovim-init/
--
-- To set options in Lua, use the vim.opt table
-- which behaves exactly like the set function in Vimscript.
-- This table should cover most usages.

-- Otherwise, Neovim Lua API provides 3 tables
-- if you need to specifically set
-- an option locally (only a buffer or in a window) or globally:

--    vim.o to set global options: vim.o.hidden = true
--    vim.bo to set buffer-scoped options: vim.bo.expandtab = true
--    vim.wo to set window-scoped options: vim.wo.number = true

-- some of them will require you to set both
-- vim.o.{option} and vim.{wo/bo}.{option} to work properly.

-- To know on which scope a particular option acts on, check Vim help pages.

--=======================================--
--                Buffers                --
--=======================================--

-- Removes annoying constrainst that doesn't
-- allow yout to switch between unsave buffers
-- WARNING: be carefull when using :q! or :qa!
vim.opt.hidden = true
vim.opt.swapfile = false

--=======================================--
--                Compe                  --
--=======================================--

-- Required for compe
vim.o.completeopt = "menuone,noselect"

-- Remove annoying `pattern not found`
-- from nvim command line when typing
-- if: vim.o.showmode = false
-- OR if showmode is unchanged
-- remove crazy `--INSERT--` blinking
-- from the command line when typing
-- see: https://github.com/hrsh7th/nvim-compe#how-to-remove-pattern-not-found
-- see: https://www.reddit.com/r/neovim/comments/m5n28z/neovim_lsp_keeps_saying_pattern_not_found/
vim.cmd('set shortmess+=c') -- Don't pass messages to |ins-completion-menu|.

--=======================================--
--                Colors                 --
--=======================================--

-- in vim script: set termguicolors
-- TODO: list plugins that require this option
vim.o.termguicolors = true

--=======================================--
--                Mouse                  --
--=======================================--

-- Enable mouse scrolling in vim while in tmux
-- This will disable numbers selection when selecting
-- text with the mouse too
-- See: https://superuser.com/questions/610114/tmux-enable-mouse-scrolling-in-vim-instead-of-history-buffer
-- See: https://vim.fandom.com/wiki/Using_the_mouse_for_Vim_in_an_xterm
vim.o.mouse = "a"

--=======================================--
--              Clipboard                --
--=======================================--

-- Enable access to system clipboard with +y operator
-- see: https://advancedweb.hu/working-with-the-system-clipboard-in-vim/
-- Set the + register as the default: :set clipboard=unnamedplus.
-- Now every time you press y or p, Vim will use the system clipboard.
-- Yank to the system clipboard explicitly only when you need it with "+y, and paste from it with "+p.
-- TODO: integrate yanking with kitty private copy_paste buffer
vim.o.clipboard = "unnamedplus"

--=======================================--
--        Numbers & Sign colum           --
--=======================================--

vim.opt.number = true -- show numbers next to sign column
vim.opt.relativenumber = true -- show relative numbers

-- Avoid annoying "ping-pong" of gitsigns, markers and so on on sign column:
-- for more options see: help s'signcolumn'
-- also see: https://www.reddit.com/r/neovim/comments/f04fao/my_biggest_vimneovim_wish_single_width_sign_column/
vim.wo.signcolumn = "yes:2"

-- enable cursorline
vim.wo.cursorline = true

-- conceal
-- Concealed text is completely hidden unless
-- it has a custom replacement character defined
vim.wo.conceallevel=2

--=======================================--
--                 List                  --
--=======================================--

vim.wo.list = true
vim.wo.listchars =
    table.concat(
    {
        -- "eol:↴", -- ui gets to crowded with it
        -- "tab:│⋅", -- the same
        "tab:│ ", -- the same
        "trail:•",
        "extends:❯",
        "precedes:❮",
        "nbsp:_",
        -- "space:⋅" -- ui gets to crowded with it
    },
    ","
)

vim.o.showbreak = "↳⋅"

--=======================================--
--         Splits, tabs and spaces       --
--=======================================--

-- " General: tab equals 4 spaces, expand tabs as spaces
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- expand <Tab> as spaces

-- " nvim panes
vim.opt.splitright = true -- always vsplit to the right
vim.opt.splitbelow = true -- always split below

--=======================================--
--              Command line             --
--=======================================--

-- Hide mode from command line
vim.o.showmode = false

--=======================================--
--=======================================--
--               Netrw                   --
--=======================================--

-- Unload default vim/neovim netrw plugin
-- This will unload netrw's mappings too
-- vim.g.loaded_netrwPlugin = false

-- TODO: code folding configuration
-- TODO: setlocal path configuration
-- TODO: setlocal wildignore configuration
-- TODO: configure `wrapscan` option
-- When the search reaches the end of the file it will continue
-- at the start, unless the 'wrapscan' option has been reset.
