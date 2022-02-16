--=======================================--
--              About settings           --
--=======================================--

-- see: https://oroques.dev/notes/neovim-init/

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

--==============================================--
-- Disable unused default nvim standard plugins --
--==============================================--

-- Disable some unused built-in Neovim plugins
-- stylua: ignore
local disabled_built_ins = {
  "netrw",             -- TODO: see what this built in plugin does
  "gzip",              -- TODO: see what this built in plugin does
  "zip",               -- TODO: see what this built in plugin does
  "netrwPlugin",       -- TODO: see what this built in plugin does
  "netrwSettings",     -- TODO: see what this built in plugin does
  "tar",               -- TODO: see what this built in plugin does
  "tarPlugin",         -- TODO: see what this built in plugin does
  "netrwFileHandlers", -- TODO: see what this built in plugin does
  "zipPlugin",         -- TODO: see what this built in plugin does
  "getscript",         -- TODO: see what this built in plugin does
  "getscriptPlugin",   -- TODO: see what this built in plugin does
  "vimball",           -- TODO: see what this built in plugin does
  "vimballPlugin",     -- TODO: see what this built in plugin does
  "2html_plugin",      -- TODO: see what this built in plugin does
  "logipat",           -- TODO: see what this built in plugin does
  "spellfile_plugin",  -- TODO: see what this built in plugin does
  "matchit",           -- using matchup instead
  "matchparen",        -- using matchup instead
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

--=======================================--
--              Providers                --
--=======================================--

-- Neovim delegates some features to dynamic "providers".
-- See: help provider
--
-- To check the provider status and the need of an upgrade run:
--  ":checkhealth provider"

-- Python provider
-- NOTE: Python 2 IS NOT supported anymore
-- Virtualenvs are used often so it's better to hard-code a Neovim only interpreter using |g:python3_host_prog|
-- so that the "pynvim" package is not required for each virtualenv. See: help python-virtualenv
--
-- TODO: include which plugins need python3
-- used by (don't remember because i didn't take notes)
--
-- needs: pynvim package: `$ pip install pynvim`. See: https://github.com/neovim/pynvim
vim.g.python3_host_prog = vim.env.HOME .. "/.local/share/nvim/nvim-hardcoded-pythons/py3nvim/venv/bin/python"

-- Ruby provider
-- Command to start the Ruby host. By default this is "neovim-ruby-host". With
-- project-local Ruby versions (via tools like RVM or rbenv) setting this can
-- avoid the need to install the "neovim" gem in every project.
--
-- needs neovim ruby gem. `$ gem install neovim`
vim.g.ruby_host_prog = vim.env.HOME .. "/.local/share/gem/ruby/3.0.0/bin/neovim-ruby-host"

-- Perl provider
-- AFIK no plugins in my config use Perl as a provider,
-- TODO: check if any installed plugins use Perl provider
--
-- Needs "Neovim::Ext" cpan package, do:
--  ` $ cpan App::cpanminus`
--  ` $ cpanm Neovim::Ext`
-- see: http://www.cpan.org/modules/INSTALL.html
if vim.fn.has "unix" == 1 then -- Linux perl PATH configuration
  vim.g.perl_host_prog = "/usr/bin/perl"
end
-- TODO: include macos Homebrew Perl PATH configuration

-- Nodejs provider
-- By default, Nvim searches for "neovim-node-host" using "npm root -g", which
-- can be slow. To avoid this we declare neovim-node-host directly
--
-- needs neovim package: `$ yarn global add neovim`
vim.g.node_host_prog = vim.env.HOME .. "/.yarn/bin/neovim-node-host"

-- Clipboard integration
-- see: help clibpoard
--
-- Linux: it's better to use xclip, TODO: list reasons for using xclip instead of xsel
-- macOS: uses pbcopy by default, TODO: see if pbcopy works well and replace it if needed
--
-- Enable access to system clipboard with +y operator
-- see: https://advancedweb.hu/working-with-the-system-clipboard-in-vim/
-- Set the + register as the default: :set clipboard=unnamedplus.
-- Now every time you press y or p, Vim will use the system clipboard.
-- Yank to the system clipboard explicitly only when you need it with "+y, and paste from it with "+p.
-- TODO: integrate yanking with kitty private copy_paste buffer --> see: help clipboard
--
-- see: https://stackoverflow.com/questions/30691466/what-is-difference-between-vims-clipboard-unnamed-and-unnamedplus-settings
-- BUG: block paste doesn't work with Neovim natively (vim 8 works) when clipboard is unnamed or unnamedplus
-- see: https://github.com/neovim/neovim/issues/1822
-- A workaround is to use either nvim-miniyank or pastefix.vim
vim.o.clipboard = "unnamedplus"

--=======================================--
--                Confirm                --
--=======================================--

-- Execute {command},
-- and use a dialog when an
-- operation has to be confirmed.
vim.o.confirm = true

--=======================================--
--                Swap                   --
--=======================================--

-- Disables swapfile
-- See: https://vi.stackexchange.com/questions/177/what-is-the-purpose-of-swap-files
vim.opt.swapfile = false

--=======================================--
--                Colors                 --
--=======================================--

-- required by some plugins
-- to display colors properly
vim.o.termguicolors = true

--=======================================--
--                Mouse                  --
--=======================================--

-- Enable mouse mode
-- Enable mouse scrolling in vim while in tmux
-- This will disable numbers selection when selecting
-- text with the mouse too
-- See: https://superuser.com/questions/610114/tmux-enable-mouse-scrolling-in-vim-instead-of-history-buffer
-- See: https://vim.fandom.com/wiki/Using_the_mouse_for_Vim_in_an_xterm
vim.o.mouse = "a"

--=======================================--
--                 Search                --
--=======================================--

-- Case insensitive searching UNLESS /C or capital in search

vim.o.ignorecase = true
vim.o.smartcase = true

-- Enables wrapscan ONLY for the first matched search item,
-- meaning the first search will be bidirectional.
-- After the first search, when repeating it using 'n' or 'N' wrapscan will be turned off,
-- meaning the search will stop on the last matched item of the file (top or bottom).
--
-- taken from: https://www.reddit.com/r/vim/comments/mtvq9l/wrapscan_only_for_first_match/
vim.cmd [[
  augroup SearchWrap
    autocmd!
    autocmd CmdlineEnter [/?] set wrapscan
    autocmd CmdlineLeave [/?] call timer_start(1, {-> execute('set nowrapscan')})
  augroup END
]]

--=======================================--
--                Time                   --
--=======================================--

-- Update time
-- Used by:
--     Swap File: A swap file (if swap file is enabled) will be written to disk if nothing is typed in the time specified.
--     CursorHold: If nothing is typed in the time specified than an action happens. Not triggered until the user has pressed a key.
--        e.g.: press a key, wait updatetime seconds, then action happen
--
-- Note: antoinemadec/FixCursorHold.nvim plugin is being used,
-- so it is possible to use small delays for CursorHold without writing the swap file unnecessarily
-- because FixCursorHold decouples updatetime from CursorHold and CursorHoldI
-- This means that in this setup `updatetime` ONLY applies to the swap file.
-- FixCursorHold.nvim has a global option `g:cursorhold_updatetime`,
-- used for both CursorHold and CursorHoldI, that if not defined
-- will use Neovim's `updatetime` instead, meaning that in this case
-- `updatetime` will apply for both Swap file and CursorHold (and CursorHoldI).
vim.o.updatetime = 4000 -- Neovim default value, in ms

vim.o.timeoutlen = 250 -- in ms
-- Time in milliseconds to wait for a mapped sequence to complete.
-- A mapped key sequence is a succession of keycodes triggering an action
--
-- Tip: DO NOT use 0 because it can break complex mappings, such as insert mode ones.
--
-- e.g.:
--     inoremap jk <esc>
--
--     When you type j in insert mode Neovim will wait `timeoutlen` milliseconds
--     for you to press k before deciding what the intent is.
--     see: https://vi.stackexchange.com/questions/10249/what-is-the-difference-between-mapped-key-sequences-and-key-codes-timeoutl
--
-- WhichKey.nvim plugin uses this setting too, it's the time it waits before being triggered.

--=======================================--
--    Numbers, sign column and cursor    --
--=======================================--

vim.opt.number = true -- show current line number
vim.opt.relativenumber = true -- show relative numbers

-- Avoid annoying "ping-pong" of gitsigns, markers and so on on sign column:
-- for more options see: help s'signcolumn'
-- also see: https://www.reddit.com/r/neovim/comments/f04fao/my_biggest_vimneovim_wish_single_width_sign_column/
vim.wo.signcolumn = "yes:2"

-- https://vi.stackexchange.com/questions/27989/how-to-highlight-cursor-line-number-without-cursor-line
vim.wo.cursorline = true -- sets cursorline
vim.wo.cursorlineopt = "number" -- enable only the number of cursorline, > 0.6 only

--=======================================--
--               Shortmess               --
--=======================================--

vim.opt.shortmess:append "ISc"

-- I: don't give the intro message when starting Vim.
-- S: suppress search results, e.g.: [1/20] on the vim commanad line
--    google/vim-searchindex plugin already disables it when installed

-- c: don't give |ins-completion-menu| messages.
--    messages such as "match 1 of 2"
--    when using nvim-cmp (ONLY in native view mode),  see: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
--    which makes Neovim cmdline blink REALLY fast,
--    and when using default Neovim completions such as i_CTRL-X_CTRL-I

--=======================================--
--                 List                  --
--=======================================--

vim.wo.list = true

-- lukas reineke
vim.opt.listchars = {
  -- space = "⋅", -- space char. too distracting
  -- eol = "↴", -- shows at end of line. too distracting
  tab = "│⋅", -- MUST be 2 char wide
  -- tab = "│▸",
  trail = "•", -- trailing spaces, using vim-better-whitespace instead
  extends = "❯", -- character that shows when there is overflowing text and nowrap is set
  precedes = "❮", -- same as above in the opposite direction
  nbsp = "_", -- Character to show for a non-breakable space character, TODO: see this in action
}

vim.o.showbreak = "↳⋅" -- show this character before warped text, useful in splits

--=======================================--
--     Splits, indent, tabs and spaces   --
--=======================================--

-- General tab and spacing
-- tab = 4 spaces, expand tabs as spaces
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true -- round the indent to a multiple of 'shiftwidth' <3
vim.opt.expandtab = true -- expand <Tab> as spaces

-- nvim panes
vim.opt.splitright = true -- always split vertically to the right instead of the default left
vim.opt.splitbelow = true -- always split horizontally to bottom instead of the default top

-- Every wrapped line will continue visually indented
-- (same amount of space as the beginning of that line),
-- thus preserving horizontal blocks of text.
vim.o.breakindent = true

-- Remap for dealing with word wrap (respecting breakindent)
-- j,k Navigation happens by respecting indent in this case instead of jumping potentially desidered characters by row number
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

vim.wo.wrap = false

vim.wo.linebreak = true -- break only at specific chars

-- only applies if linebreak is set to true
-- uses tabs and spaces as break charcaters, other special chars
-- can be annoying to break text when coding
vim.o.breakat = " ^I"

--=======================================--
--              Completion               --
--=======================================--

-- TODO: learn more about completeopt
-- Set completeopt to have a better completion experience
-- came from defaults.nvim
-- see: |ins-completion-menu|
vim.o.completeopt = "menuone,noselect"

--=======================================--
--              Spelling                 --
--=======================================--

-- spellfile path
-- It must end in ".{encoding}.add".
-- This is the default path but it is explicitly set here for reference
-- TODO: check spell-sug-files,
-- see: `h: spell-sug-file`
vim.opt.spellfile = vim.fn.stdpath "config" .. "/spell/en.utf-8.add"

--=======================================--
--          Undo & backup                --
--=======================================--

vim.opt.backup = false -- default

-- this helps with some formatters that otherwise require saving two times
-- and -- if a file is being edited by another program
-- (or was written to file while editing with another program), it is not allowed to be edited
-- vim.opt.writebackup = false

-- Save undo history
-- TODO: include more explanation
vim.opt.undofile = true

--=======================================--
--              Clipboard                --
--=======================================--

-- Enable access to system clipboard with +y operator
-- see: https://advancedweb.hu/working-with-the-system-clipboard-in-vim/
-- Set the + register as the default: :set clipboard=unnamedplus.
-- Now every time you press y or p, Vim will use the system clipboard.
-- Yank to the system clipboard explicitly only when you need it with "+y, and paste from it with "+p.
-- TODO: integrate yanking with kitty private copy_paste buffer --> see: help clipboard

-- see: https://stackoverflow.com/questions/30691466/what-is-difference-between-vims-clipboard-unnamed-and-unnamedplus-settings
-- BUG: block paste doesn't work with Neovim natively (vim 8 works) when clipboard is unnamed or unnamedplus
-- see: https://github.com/neovim/neovim/issues/1822
-- A workaround is to use either nvim-miniyank or pastefix.vim
vim.o.clipboard = "unnamedplus"

-- =======================================--
--                 Yank                   --
-- =======================================--

-- Highlight text on yank
-- For more information see h: lua-highlight
-- The first parameter is the highlight group to use,
-- and the second is the highlight duration time in ms
-- See: https://jdhao.github.io/2020/05/22/highlight_yank_region_nvim/
-- See: https://github.com/mjlbach/defaults.nvim/blob/master/init.lua

vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup END
]]

--=======================================--
--               Command line            --
--=======================================--

-- Hide mode from command line,
-- which is good when using a status line plugin
-- like lualine or galaxyline
vim.o.showmode = false

--=======================================--
--          Filetype detection           --
--=======================================--

-- see:https://www.reddit.com/r/neovim/comments/rvwsl3/introducing_filetypelua_and_a_call_for_help/

-- testing: enable filetype.lua, still opt-in
vim.g.do_filetype_lua = 1

-- disable filetype.vim and use only filetype.lua
-- DO NOT use because filetype.lua doesn't have feature parity with filetype.vim yet
-- vim.g.did_load_filetypes = 0

--=======================================--
--               Netrw                   --
--=======================================--

-- TODO: check netrw and why it is not (?) working, it's almost certain a plugin doing this hijack

-- TODO: check for any conflicts with nvim-tree.lua
-- Unload default vim/neovim netrw plugin
-- This will unload netrw's mappings too
-- vim.g.loaded_netrwPlugin = false

--=======================================--
--        Scrolloff & Sidescroll         --
--=======================================--

-- UNUSED because scrolloff is being set conditionally
-- by window size using drzel/vim-scrolloff-fraction plugin
-- vim.o.scrolloff = 8

-- non wrapped text cursor offset
vim.o.sidescrolloff = 15

--=======================================--
--               Shada                   --
--=======================================--

-- TODO: check it better, this settings is hell
-- vim.opt.shada = "!,'0,f0,<50,s10,h"

--=======================================--
--               Buffer draw             --
--=======================================--

-- speed up macros
-- TODO: which side effects does this option have?
-- see: https://github.com/neovim/neovim/issues/6289#issuecomment-344147991
-- vim.o.lazyredraw = true

--=======================================--
--              Mapped opt               --
--=======================================--
-- TODO: edit this

local opt = setmetatable({}, {
  __newindex = function(_, key, value)
    vim.o[key] = value
    vim.bo[key] = value
  end,
})

-- requires rg installed, TODO: include in install script
-- opt.grepprg = "rg --vimgrep --no-heading --hidden"

-- opt.formatoptions = "bcjnrt"

-- opt.dict = "~/dotfiles/lib/10k.txt"
-- opt.expandtab = true
-- opt.shiftwidth = 4
-- opt.smartindent = true
-- opt.softtabstop = 4
-- opt.spellcapcheck = ""
-- opt.swapfile = false
-- opt.tabstop = 4
-- opt.textwidth = 80
-- opt.undofile = true
-- opt.undolevels = 10000

--=======================================--
--               Wild's                  --
--=======================================--

-- Ignore files
-- set wildignore+=*.pyc
-- set wildignore+=*_build/*
-- set wildignore+=**/coverage/*
-- set wildignore+=**/node_modules/*
-- set wildignore+=**/android/*
-- set wildignore+=**/ios/*
-- set wildignore+=**/.git/*
-- ".hg,.git,.svn"

-- TODO: learn how to set wildignore properly,
-- does path matters?
-- see: https://www.reddit.com/r/vim/comments/cc8m1n/ignore_for_real_folders_when_using_find/
-- see: https://vimways.org/2018/death-by-a-thousand-files/
vim.opt.wildignore:append ".git"

-- TODO: leave diffopt at default?
vim.o.diffopt = "internal,filler,closeoff,foldcolumn:0,hiddenoff"

--=======================================--
--               TODO's                  --
--=======================================--

-- useful but REALLY overkill, see: h starstar-wildcard
-- see: https://vimways.org/2018/death-by-a-thousand-files/
-- vim.opt.path:append "**"

-- TODO: search and configure wildmode option

-- TODO: read https://neovim.discourse.group/t/the-300-line-init-lua-challenge/227
