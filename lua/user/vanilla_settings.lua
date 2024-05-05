-- TODO: remove autogroups from this file

--=======================================--
--              About settings           --
--=======================================--

-- To set options in Lua, use the vim.opt table
-- which behaves exactly like the set function in Vimscript.
-- This table should cover most usages.

-- Otherwise, Neovim Lua API provides 3 tables
-- if you need to specifically set an option locally
-- (only in a buffer or in a window for example) or globally then use:

--    vim.o to get or set global options, e.g.: vim.o.hidden = true, vim.o.cmdheight = 4
--    vim.bo to get or set buffer-scoped options, e.g.: vim.bo.expandtab = true.
--      NOTE: this is equivalent to both :set and :setlocal
--    vim.wo to get or set window-scoped options, e.g.: vim.wo.number = true

-- some of them will require you to set both
-- vim.o.{option} and vim.{wo/bo}.{option} to work properly.

-- To know on which scope a particular option acts on, check Vim help pages.

--==============================================--
--    Disable unused Neovim standard plugins    --
--==============================================--

-- TODO: clarify this section

-- SEE: https://www.reddit.com/r/neovim/comments/oo9kgj/in_need_of_some_help_with_startup_time/

-- TODO: include brief explanation of the disabled builtin plugins and why it was disabled
-- TODO: see what the uncommented built in plugin does
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

-- vim.g.loaded_matchit = 1 -- using matchup instead
vim.g.loaded_matchparen = 1 -- This variable has no effect on andymass/vim-matchup plugin
vim.g.loaded_logipat = 1
-- vim.g.loaded_spellfile_plugin = 1 -- load it because it is usefull

-- WARN: testing nvim-tree vinegar mode
-- Unload default (Neo)vim netrw plugin
-- This will unload netrw's mappings too
-- vim.g.loaded_netrwPlugin = false
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

--=======================================--
--              Providers                --
--=======================================--

-- Neovim delegates some features to dynamic "providers".
-- SEE: :help provider
--
-- To check the provider status and the need of an upgrade run:
--   :checkhealth provider

-- Language providers (Python, Ruby, Perl and Nodejs)
-- WARN: for some reason this require stoped working when I transitioned from
--       packer.nvim to lazy.nvim
local providers_status_ok, providers = pcall(require, "user.modules.providers")

-- return providers module as a table
if providers_status_ok then
  providers["dir"] = vim.env.HOME .. "/.local/share/nvim/providers"

  -- {{{ Python provider

  -- NOTE: Python 2 IS NOT supported anymore
  -- Needs: Python >= 3.4 and pynvim python package.
  --        SEE: https://github.com/neovim/pynvim
  --
  -- Virtualenvs are used often in python projects so it's better to hard-code
  -- a Neovim only interpreter using |g:python3_host_prog|
  -- That way pynvim package is not required for each virtualenv you use.
  --   SEE: help python-virtualenv
  --
  -- TODO: include which plugins that I use that needs python3
  -- used by (vim-rfc)

  -- local python3_nvim_venv_path = providers["dir"] .. "/python3"
  -- local python3_path = python3_nvim_venv_path .. "/bin/python"
  --
  -- if providers.provider_exists(python3_path) then
  --   vim.g.python3_host_prog = python3_path
  -- else
  --   providers.install_python_provider(python3_nvim_venv_path, python3_path)
  -- end

  -- }}}

  -- {{{ Ruby provider

  -- Command to start the Ruby host. By default this is "neovim-ruby-host".
  -- When using project-local Ruby versions (via tools like RVM or rbenv)
  -- setting this will avoid the need to install the "neovim" gem in every project.
  -- WARN: it is not setup
  -- TODO: automate it
  --
  -- needs neovim ruby gem. `$ gem install neovim`
  -- local ruby_gem_path = providers["dir"] .. "/ruby"
  -- local neovim_ruby_host_gem_path = ruby_gem_path .. "/bin/neovim-ruby-host"
  --
  -- SEE: https://stackoverflow.com/questions/16098757/specify-gem-installation-directory
  -- vim.g.ruby_host_prog = "/tmp/testing_default_ruby/bin/neovim-ruby-host"

  -- }}}

  -- {{{ Perl provider

  -- AFAIK no plugins in my config use Perl as a provider,
  -- TODO: check if any installed plugins use Perl provider
  -- WARN: it is not setup
  -- TODO: automate it
  --
  -- Needs "Neovim::Ext" cpan package, do:
  --  ` $ cpan App::cpanminus`
  --  ` $ cpanm Neovim::Ext`
  -- SEE: http://www.cpan.org/modules/INSTALL.html
  -- if vim.fn.has "unix" == 1 then -- Linux perl PATH configuration
  --   vim.g.perl_host_prog = "/usr/bin/perl"
  -- end
  -- TODO: include macos Homebrew Perl PATH configuration

  -- }}}

  -- {{{ Nodejs provider

  -- By default, Nvim searches for "neovim-node-host" using "npm root -g", which
  -- can be slow. To avoid this we declare neovim-node-host directly
  --
  -- needs neovim package: `$ yarn global add neovim`
  -- WARN: it is not setup
  -- TODO: automate it
  vim.g.node_host_prog = vim.env.HOME .. "/.yarn/bin/neovim-node-host"
  -- vim.g.node_host_prog = "/Users/development/.asdf/installs/nodejs/18.12.1/bin/neovim-node-host"

  -- }}}

  -- {{{ Clipboard provider

  -- TODO: is it possible to use Alfred clipboard as a macos provider?

  -- SEE: :help clipboard
  --      :help clipboard-unnamed
  --      :help clipboard-unnamedplus
  --      :help registers
  --
  -- Linux: it's better to use xclip, TODO: list reasons for using xclip instead of xsel
  -- macOS: uses pbcopy by default, TODO: see if pbcopy works well and replace it if needed

  -- NOTE: Block paste from system clipboard was fixed in #14842 (see: https://github.com/neovim/neovim/pull/14848)

  -- NOTE: Important concepts below:
  --
  -- Nvim has NO direct connection to the system clipboard.
  -- Instead it depends on a provider which transparently uses shell commands
  -- to communicate with the system clipboard or any other clipboard "backend".
  --
  -- * The unnamed register:
  --
  --     Nvim has a unnamed (or default) register that can be accessed with "".
  --     Any text that you delete (with d, c, s or x) or yank (with y) will be placed there,
  --     and that’s what Nvim uses to paste, when no explicit register is given.
  --     A simple p is the same thing as doing ""p.
  --
  -- * The system clipboard:
  --     A.K.A the good and old Ctrl-C, Ctrl-V, Cmd-C, Cmd-V, mapped to register '+'
  --
  -- * The selection clipboard:
  --     A.K.A pasting with the middle click of the mouse, mapped to register '*'
  --     WARN: The concept of selection clipboard, that is,
  --           the text you SELECT getting copied into a clipboard of its own
  --           DOESN'T EXIST IN MACOS AND WINDOWS FOR SOME REASON.
  --           Remember that the selection clipboard WILL SYNC with system clipboard ONLY on macos and Windows
  --           SEE: https://superuser.com/questions/87470/copy-on-select-paste-on-middle-click-on-mac-os-x
  --           SEE: https://stackoverflow.com/questions/30691466/what-is-difference-between-vims-clipboard-unnamed-and-unnamedplus-settings

  -- USING ONLY UNNAMED AS CLIPBOARD:
  --
  --   Vim will use the clipboard register '*' (selection clipboard)
  --   for all yank, delete, change and put operations which
  --   would normally go to the unnamed register.
  --   WARN: REMEMBER that on macos and Windows, the * and + registers both point to the system clipboard
  --         so unnamed and unnamedplus have the same effect: the unnamed register is synchronized with the system clipboard.
  --         SEE: https://stackoverflow.com/questions/30691466/what-is-difference-between-vims-clipboard-unnamed-and-unnamedplus-settings
  --   NOTE: On Linux I want my selection clipboard to be untouched so I won't use this option
  -- vim.o.clipboard = "unnamed"

  -- USING ONLY UNNAMEDPLUS AS CLIPBOARD:
  --
  --   A variant of the "unnamed" flag which uses the
  --   clipboard register quoteplus '+' (the system clipboard ) instead of
  --   register '*' (selection clipboard) for all yank, delete, change and put
  --   operations which would normally go to the unnamed register.
  --   WARN: REMEMBER that macos and Windows, the * and + registers both point to the system clipboard
  --         so unnamed and unnamedplus have the same effect: the unnamed register is synchronized with the system clipboard.
  --         SEE: https://stackoverflow.com/questions/30691466/what-is-difference-between-vims-clipboard-unnamed-and-unnamedplus-settings
  --   NOTE: I want my system clipboard to ALWAYS be untouched unless I explicitly call it
  --         because I often pasted unwanted code in Whatsapp / mail / web when I used this option,
  --         but if I didn't wanted this would be the way to go because selection clipboard would be free from Nvim influence on Linux.
  -- vim.o.clipboard = "unnamedplus"

  -- UNNAMED AND UNNAMEDPLUS SET TOGETHER:
  --
  --   When "unnamed" is also included to the option unnamedplus,
  --   yank and delete operations (but not put)
  --   will additionally copy the text into register
  --   '*'. See :h clipboard.
  -- vim.o.clipboard = "unnamed,unnamedplus"

  -- NO CLIPBOARD (CURRENT)
  -- TODO: include reasoning
  -- Yank to the system clipboard explicitly only when you need it with "+y, and paste from it with "+p.
  -- NOTE: I use <leader>y as a quick "+y shortcut
  -- NOTE: on macos this is pretty comfortable without any thinkering because there's the command key,
  --       making Cmd-v an easy way to access the system clipboard.
  --       TODO: On Linux and Windows I will have to think of a more involved alternative if I want to use no clipboard.
  --             Maybe a quick mapping to "+p would be an easy way to solve this.
  vim.o.clipboard = "" -- This is Vim/Nvim default

  -- TODO: Integrate Nvim yanking with kitty private copy_paste buffer --> see: help clipboard
  -- TODO: Plugin Idea: When you copy text using the mouse or [Ctrl/Cmd]-v
  --       automatically copy the system clipboard to any Nvim register you set
  --       Make the copied text persistent using a sqlite database, just like nvim-neoclip.lua does
  --       SEE: https://github.com/AckslD/nvim-neoclip.lua/pull/58

  -- }}}
end

--=======================================--
--                Registers              --
--=======================================--

-- TODO: does registers has anything to do with shada and shada-file?

-- Registers are persisted across Nvim sessions,
-- this makes things messy when you quit a session and start another one that has
-- nothing to deal with the previous.
--
-- EmptyRegisters function and command clean Nvim registers.
-- EmptyRegistersGroup augroup cleans Nvim registers when you start Nvim,
-- preventing the situation described above.

-- TODO: convert to lua
-- SEE: Taken from https://stackoverflow.com/a/39348498
-- SEE: https://vi.stackexchange.com/questions/467/how-can-i-clear-a-register-multiple-registers-completely
--
-- TODO: refactor it so it won't empty the unnamed register (")
--       For some reason removing " from split function doesn't seem to work
-- WORKAROUND: (doesn't work) in EmptyRegistersGroup I set the last unnamed register content to a global variable
--             then empty all registers than assign @" to this global variable
vim.cmd([[
function! EmptyRegisters()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfunction
]])

vim.cmd([[command EmptyRegisters call EmptyRegisters()]])

vim.cmd([[
augroup EmptyRegistersGroup
    " autocmd VimEnter * let g:last_unnamedregister_content_before_quiting_nvim = @"
    autocmd VimEnter * call EmptyRegisters()
    " autocmd VimEnter * let @" = g:last_unnamedregister_content_before_quiting_nvim
augroup END
]])

--=======================================--
--                Confirm                --
--=======================================--

-- Execute {command},
-- and use a dialog when an
-- operation has to be confirmed.
-- useful when using no hidden buffers (':set nohidden', original VIM defaults to nohidden, Neovim to hidden)
-- and when there's unnamed files with content inside: Neovim will ask what do you want to do with the file.
-- TODO: check if this is true: and when there's changes in the files triggered by an external program (Neovim will confront if you change to discard the change or not). e.g.: package-info.nvim plugin
-- vim.o.confirm = true

vim.o.confirm = false
-- can be dangerous to use true when using a plugin that manages files and dir
-- with a buffer like dirbuf.nvim and vim-dirvish-dovish

--=======================================--
--                Colors                 --
--=======================================--

-- Enables 24-bit RGB color in the |TUI|. Uses "gui" |:highlight|
-- attributes instead of "cterm" attributes.
-- required by some plugins to display colors properly
vim.o.termguicolors = true

--=======================================--
--                Mouse                  --
--=======================================--

-- Enable mouse mode
-- Enable mouse scrolling in vim while in tmux
-- This will disable numbers selection when selecting text with the mouse too
-- SEE: https://superuser.com/questions/610114/tmux-enable-mouse-scrolling-in-vim-instead-of-history-buffer
-- SEE: https://vim.fandom.com/wiki/Using_the_mouse_for_Vim_in_an_xterm
vim.o.mouse = "a"

--=======================================--
--                 Search                --
--=======================================--

-- Ignore the case of normal letters
-- e.g.: searching for 'Searchwrap', 'SearchWrap', 'searchwrap', 'searchWrap', 'SEARCHWRAP' will be the same
--       when ignorecase is true and smartcase is false.
-- NOTE: use \C for forcing matching case for the whole pattern:
--      e.g.: /\Csearch    or    /search\C
-- NOTE: docs says that only Vim supports \c and \C but it seems to work fine
vim.o.ignorecase = true -- defaults to false
--
-- Override the 'ignorecase' option if the search pattern contains upper case characters.
-- Only used when the search pattern is typed and 'ignorecase' option is true
vim.o.smartcase = true -- defaults to false

-- Enables wrapscan ONLY for the first matched search item,
-- meaning the first search will be bidirectional, jumping to the first occurrence of the searched term,
-- doesn't matter if the occurrence is above or below your current cursor position.
-- After the first search, when repeating it using 'n' or 'N' wrapscan will be turned off,
-- meaning the search will stop on the last matched item of the file (top or bottom).
--
-- SEE: taken from: https://www.reddit.com/r/vim/comments/mtvq9l/wrapscan_only_for_first_match/
vim.cmd([[
  augroup SearchWrap
    autocmd!
    autocmd CmdlineEnter [/?] set wrapscan
    autocmd CmdlineLeave [/?] call timer_start(1, {-> execute('set nowrapscan')})
  augroup END
]])

-- Display first searched (/?) term at the center of the window
-- WARN: Testing (started: 2022/11/20)
-- NOTE: zz only works when text CAN be displayed at the center. This is not always the case.
-- Taken from: https://vi.stackexchange.com/a/31134
--
-- SEE: https://www.reddit.com/r/vim/comments/cgpnbf/automatically_zz_after_jump/
-- SEE: https://vi.stackexchange.com/questions/13641/how-can-i-center-the-window-on-each-search-result
-- SEE: https://vi.stackexchange.com/questions/10775/how-can-i-automatically-center-first-search-result
-- SEE: https://github.com/junegunn/vim-slash
--
vim.cmd([[
  augroup DisplayFirstSearchedTermAtTheTopOfWindow
    autocmd!
    autocmd CmdlineEnter /,\?
      \ if empty(v:operator) |
      \   cnoremap <CR> <CR>zz|
      \ endif
    autocmd CmdlineLeave /,\?
      \ if empty(v:operator) |
      \   cunmap <CR>|
      \ endif
  augroup END
]])

--=======================================--
--                Time                   --
--=======================================--

-- Update time
-- Used by:
--     Swap File: A swap file (if swap file is enabled) will be written to disk if nothing is typed in the time specified.
--     CursorHold: If nothing is typed in the time specified than an action happens. Not triggered until the user has pressed a key.
--        e.g.: press a key, wait updatetime seconds, then action happen
--
-- `updatetime` will apply for both Swap file and CursorHold (and CursorHoldI).
vim.o.updatetime = 50 -- Neovim default value, in ms
-- NOTE: was using 250, trying 50

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
--     SEE: https://vi.stackexchange.com/questions/10249/what-is-the-difference-between-mapped-key-sequences-and-key-codes-timeoutl
--
-- WhichKey.nvim plugin uses this setting too, it's the time it waits before being triggered.

-- TODO: set ttimeoutlen
-- SEE: https://www.johnhawthorn.com/2012/09/vi-escape-delays/

--=======================================--
--    Numbers, sign column and cursor    --
--=======================================--

vim.opt.number = true -- show current line number
vim.opt.relativenumber = true

-- WARN: statuscolumn is experimental! It's a local window option.
-- NOTE: each sign (as in signcolumn still occupy two cells instead of one but statuscolumn is an improvement)
-- NOTE: `%=` separation item is used for right aligning at signcolumn.
-- TODO: find out how to set this to be ignore for some filetypes such as telescope.
-- vim.o.statuscolumn = "%=%l %s" -- SEE: https://www.reddit.com/r/neovim/comments/107k0cv/new_feature_statuscolumn_merged/

-- Avoid annoying "ping-pong" of gitsigns, markers and so on on sign column:
-- for more options, SEE: `:help signcolumn`
-- also SEE: https://www.reddit.com/r/neovim/comments/f04fao/my_biggest_vimneovim_wish_single_width_sign_column/
-- WARN: yes:1 is usually fine
--       TODO: use yes:2 when signs at signcolumn occupy only one cell instead of two
vim.wo.signcolumn = "yes:2"

-- https://vi.stackexchange.com/questions/27989/how-to-highlight-cursor-line-number-without-cursor-line
vim.wo.cursorline = true -- sets cursorline
vim.wo.cursorlineopt = "number" -- enable only the number of cursorline, > 0.6 only

--=======================================--
--               Shortmess               --
--=======================================--

-- TODO: explore all options
vim.opt.shortmess:append("ISc")

-- I: don't give the intro message when starting Vim.
-- S: suppress search results, e.g.: [1/20] on the vim commanad line
--    google/vim-searchindex plugin already disables it when installed

-- c: don't give |ins-completion-menu| messages.
--    messages such as "match 1 of 2"
--    when using nvim-cmp (ONLY in native view mode),  SEE: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
--    which makes Neovim cmdline blink REALLY fast,
--    and when using default Neovim completions such as i_CTRL-X_CTRL-I

-- A: don't give the "ATTENTION" message when an existing swap file
-- is found.

--=======================================--
--                 List                  --
--=======================================--

vim.wo.list = true

-- lukas reineke
vim.opt.listchars = {
  -- space = "⋅", -- space char. too distracting

  -- WARN: (N)vim doesn'show show EOL at EOF.
  -- NOTE: EOF is not actually a character, see: https://stackoverflow.com/questions/1171284/regular-expression-to-match-eof
  -- SEE: https://stackoverflow.com/questions/14171254/why-would-vim-add-a-new-line-at-the-end-of-a-file
  -- TODO: PEDRO: https://thoughtbot.com/blog/no-newline-at-end-of-file
  -- TODO: see https://vi.stackexchange.com/questions/22783/visual-indicator-for-a-file-that-doesnt-end-in-newline
  -- SEE: https://stackoverflow.com/questions/15639511/vim-show-newline-at-the-end-of-file
  -- SEE: https://vi.stackexchange.com/questions/3298/how-to-make-vim-automatically-add-a-newline-to-the-end-of-a-file
  -- SEE: :h 'fixendofline' and :h 'endofline' , on by default but can be turned off for working with cursed text files
  -- SEE: https://stackoverflow.com/questions/729692/why-should-text-files-end-with-a-newline
  -- eol = "↲", -- shows at end of line. too distracting

  tab = "│⋅", -- MUST be 2 char wide

  -- SEE: https://github.com/lukas-reineke/indent-blankline.nvim/issues/205
  -- lead = "·", -- TODO: test it more, I found it a little bit too noisy.

  -- trail = "•", -- trailing spaces, using vim-better-whitespace instead

  extends = "", -- character that shows when there is overflowing text and nowrap is set
  precedes = "", -- same as above in the opposite direction
  nbsp = "_", -- Character to show for a non-breakable space character, TODO: see this in action
}

-- NOTE: it would be good to have the possibility to define a exclusive hilight group for this
-- SEE: https://github.com/randymorris/vimscript-snippets/blob/master/showbreak_as_match.vim
-- SEE:
vim.o.showbreak = "↳⋅" -- show this character before warped text, useful in splits

--=======================================--
--                Fillchars              --
--=======================================--

vim.opt.fillchars = {
  -- Thicker fillchars then default (Characters to fill the statuslines and vertical separators.)
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",

  diff = "╱", -- diff by default uses '-' char, which is too noisy

  eob = " ", -- better than using ":highlight NonText guifg=bg"
  -- TODO: setup `fold, foldopen, foldsep and foldclose`.
  --       SEE: https://www.reddit.com/r/neovim/comments/107ms1s/the_new_signcolumn_merge_allows_us_to_set_a/
}

--=======================================--
--                Folding                --
--=======================================--

vim.o.foldlevel = 99 -- Using nvim-ufo plugin as a provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

--=======================================--
--     Splits, indent, tabs and spaces   --
--=======================================--

-- TODO: remove general tab and spacing in favor of
--       ftplugins, .editorconfig files and tpope/vim-sleuth plugin.
--
-- General tab and spacing
-- tab = 4 spaces, expand tabs as spaces
vim.opt.softtabstop = 4
vim.opt.tabstop = 4 -- show <tab> char as 4 spaces
vim.opt.shiftwidth = 4
vim.opt.shiftround = true -- round the indent to a multiple of 'shiftwidth' <3
vim.opt.expandtab = true -- expand <Tab> as spaces

-- Always show tabs, even if there's only one
vim.opt.showtabline = 2

-- TODO: would be a good idea to set this?
-- vim.opt.smartindent = true

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

-- WARN: testing
-- SEE: https://stackoverflow.com/questions/10587028/append-to-end-of-visible-line-with-wrapped-vim
-- NOTE: if i use `g$a` instead of `g$i` The cursor will enter ON the wrapped line, that is
--       on the line below the current line, this behavior is strange and confusing.
--       When using `g$i` the cursor enters the current line, which I find nicer.
-- vim.keymap.set("n", "gA", "g$i")
-- vim.api.nvim_set_keymap("n", "I", "v:count == 0 ? 'g^i' : 'I'", { noremap = true, expr = true, silent = true })

vim.wo.wrap = false

vim.wo.linebreak = true -- break only at specific chars

-- only applies if linebreak is set to true
-- uses tabs and spaces as break charcaters, other special chars
-- can be annoying to break text when coding
vim.o.breakat = " ^I"

--=======================================--
--              Completion               --
--=======================================--

-- Set completeopt to have a better completion experience
-- SEE: |ins-completion-menu|
-- in practice this will only apply when using omnifunc and other forms of standard completion
-- and won't apply to nvim_cmp
-- TODO: see how to apply similar settings to cmp

-- Otherwise 'preview' options will be REALLY annoying.
vim.opt.completeopt = { "menu", "menuone", "noselect" }

--=======================================--
--              Spelling                 --
--=======================================--

-- spellfile path, i.e. my custom words to be add to vim builtin spell function using `zg` motion
-- File must end in ".{encoding}.add".
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/user.utf-8.add"

vim.opt.spelllang = { "en", "neovim" }

-- TODO: check spell-sug-files,
-- SEE: `h: spell-sug-files`

-- NOTE: You can generate custom *.spl files with the command `:mkspell! spell/<spellfile> spell/<spellfile>.utf-8.add`
-- TODO: make an autocmd so that every time you edit one of your custom spellfiles :mkspell! runs automatically!

-- BUG: this is the default location but for some reason it is not automatically downloading languages
--      I think it's because I don't use NETRW and vim probably uses it for downloading them.
-- vim.g.spellfile_URL = "http://ftp.vim.org/vim/runtime/spell"

--=======================================--
--          Backup, Swap & Undo          --
--=======================================--

-- Better safe then sorry
vim.opt.backup = true -- defaults to false

-- this helps with some formatters that otherwise require saving two times
-- and -- if a file is being edited by another program
-- (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.writebackup = true -- defaults to true

-- double slash is on purpose
vim.opt.backupdir = { vim.env.HOME .. "/.local/state/nvim/backup//" }

-- Save undo history
-- undofiles are stored under 'undodir'
-- NOTE: I was using it set to to true already but this is required
-- for using the kevinhwang91/nvim-fundo plugin
vim.opt.undofile = true

-- Disables swapfile
-- SEE: `:help swapfile`
-- SEE: https://vi.stackexchange.com/questions/177/what-is-the-purpose-of-swap-files
-- SEE: https://stackoverflow.com/questions/821902/disabling-swap-files-creation-in-vim
vim.opt.swapfile = false

-- =======================================--
--                   Diff                 --
-- =======================================--

-- Vertical: diffs are split vertically by default unless explicitly told not to.

-- Filler: Show filler lines, to keep the text
-- synchronized (blank lines are shown) with a window that has inserted lines at the same position.
-- Mostly useful when windows are side-by-side (vsplit) and 'scrollbind' is set.

-- TODO: explore more this options, they are used with fugitive.vim and linediff.vim and others
-- TODO: explore algorithm option and foldcolumn
vim.o.diffopt = "vertical,filler,internal,closeoff,foldcolumn:0,hiddenoff,linematch:60,algorithm:minimal"

-- TODO: set a different diffexpr from vim default?
-- vim.o.diffexpr=<external program>
-- SEE: https://github.com/LemonBoy/autobahn
-- SEE: https://github.com/chrisbra/vim-diff-enhanced
-- SEE: https://github.com/Wilfred/difftastic
-- SEE: https://github.com/neovim/neovim/issues/15064

-- =======================================--
--                 Highlights             --
-- =======================================--

-- Highlight text on yank
-- For more information see h: lua-highlight
-- The first parameter is the highlight group to use,
-- and the second is the highlight duration time in ms
-- SEE: https://jdhao.github.io/2020/05/22/highlight_yank_region_nvim/
-- SEE: https://github.com/mjlbach/defaults.nvim/blob/master/init.lua

vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup END
]])

--=======================================--
--               Command line            --
--=======================================--

-- Hide mode from command line,
-- which is good when using a status line plugin
-- like lualine or galaxyline
-- and when using guicursor,
-- which makes it easy to know in which mode you are.
vim.o.showmode = false

--=======================================--
--          Filetype detection           --
--=======================================--

-- filetype.lua is default on Neovim master branch
-- SEE: https://github.com/neovim/neovim/pull/19216
-- SEE: https://www.reddit.com/r/neovim/comments/rvwsl3/introducing_filetypelua_and_a_call_for_help/
-- SEE: https://www.reddit.com/r/neovim/comments/vu46fz/psa_lua_filetype_detection_is_now_the_default_on/

-- SEE: https://github.com/neovim/neovim/issues/14090#issuecomment-1177933661
-- users who want to use the new filetype.lua mechanism SHOULD NOT set any variables (and in particular g:did_load_filetypes, see below);
-- users who want to use the old filetype.vim mechanism SHOULD let g:do_legacy_filetype = 1 (or any other value)
-- users who want to disable either mechanism SHOULD let g:did_load_filetypes = 1 (or any other value).

--=======================================--
--        Scrolloff & Sidescroll         --
--=======================================--

vim.o.scrolloff = 1 -- don't touch lines affected by vim-matchup and nvim-treesitter-context

-- non wrapped text cursor offset
vim.o.sidescrolloff = 1 -- keep cursor out of `extends` and `precedes` listchars

--=======================================--
--               Wildignore              --
--                   &                   --
--               Wildmode                --
--=======================================--

-- TODO: learn how to set wildignore properly, does path matters?
-- SEE: https://www.reddit.com/r/vim/comments/cc8m1n/ignore_for_real_folders_when_using_find/
-- SEE: https://vimways.org/2018/death-by-a-thousand-files/

-- comma separated table
vim.opt.wildignore:append({ ".git", ".next", "node_modules", ".yarn", "*.out" })

-- some popular options for ignoring files:
-- set wildignore+=*.pyc
-- set wildignore+=*_build/*
-- set wildignore+=**/coverage/*
-- set wildignore+=**/node_modules/*
-- set wildignore+=**/android/*
-- set wildignore+=**/ios/*
-- set wildignore+=**/.git/*
-- ".hg,.git,.svn"
-- TODO: search and configure wildmode option
-- TODO: read https://neovim.discourse.group/t/the-300-line-init-lua-challenge/227
-- TODO: find out if does it interfere with nvim_cmp.nvim plugin
-- vim.opt.wildmode = "full" -- default

--=======================================--
--                Shada                  --
--=======================================--

-- TODO: learn how shada really works because this setting is a mess
-- Set the shada file to not serialize mark information
-- SEE: https://github.com/chentoast/marks.nvim/issues/13#issuecomment-943394035
-- BUG: https://github.com/neovim/neovim/issues/4295
-- SEE: https://github.com/neovim/neovim/pull/16067
-- using DEFAULT shada options
-- vim.opt.shada = { "!", "'100", "<50", "s10", "h" }
-- buggy:
-- SEE: https://github.com/neovim/neovim/issues/3472
-- vim.opt.shada = { "!", "'0", "<50", "s10", "h" }

--=======================================--
--              Prose                   --
--=======================================--

-- vim.opt.dict = "~/dotfiles/lib/10k.txt"
-- vim.opt.spellcapcheck = "" -- pattern to detect the end of a sentence.
-- vim.opt.textwidth = 80
-- vim.opt.undolevels = 10000

--=======================================--
--                Cmdwin                 --
--=======================================--

vim.o.cmdwinheight = 5 -- default is 7

--=======================================--
--               Path                    --
--=======================================--

-- useful but REALLY overkill, SEE: h starstar-wildcard
-- SEE: https://vimways.org/2018/death-by-a-thousand-files/
-- SEE: https://www.reddit.com/r/vim/comments/durzh1/plugin_gotoheader_a_plugin_to_quickly_jump_to/
-- SEE: https://teukka.tech/posts/2019-08-25-vimcandothat/
-- SEE: https://teukka.tech/posts/2020-01-07-vimloop/
-- vim.opt.path:append "**"

--=======================================--
--                PRGs                   --
--=======================================--

-- TODO: learn about errorformat (:help errorformat)
-- TODO: research other prg settings

-- TODO: setup formatexpr, formatprg and equalprg

-- TODO: see https://thoughtbot.com/blog/faster-grepping-in-vim
-- Engine auto uses PCRE-2 when needed
-- SEE: https://www.reddit.com/r/neovim/comments/nyb8am/comment/h2403y3/?utm_source=share&utm_medium=web2x&context=3
vim.opt.grepprg = "rg --vimgrep --no-heading --engine auto"

-- silver-searcher option that I don't use
-- vim.opt.grepprg= "ag --vimgrep"

--=======================================--
--                Runtimepath            --
--=======================================--

-- SEE: `:h runtimepath`

-- Remove undesired plugins:
-- some distro packages come bundled with vim plugins
-- e.g.: fzf and black ($ sudo pacman -S fzf python-black)
-- those plugin get stored under the path below
-- don't allow these because the setup starts to be less portable
-- prefer to explicitly install things
-- WARN: using this on Arch Linux
vim.cmd("set rtp-=/usr/share/vim/vimfiles")
-- TODO: setup it for macos

-- Remove useless default colors, HOW??? The command below doesn't work
-- workaround: using my colorscheme.lua plugin
-- vim.cmd "set runtimepath-=/usr/share/nvim/runtime/colors"

--=======================================--
--                Includexpr             --
--=======================================--

-- TODO: :help includexpr
-- Include expr

--=======================================--
--                Formatting             --
--=======================================--

-- TODO: learn more about 'gq' normal mode command
--       SEE: https://github.com/facebook/react/pull/428

--=======================================--
--                Cmdline                --
--=======================================--

-- TODO: vim.opt.cmdheight = 0
--       NOTE: google/vim-searchindex don't like this
--       TODO: find a way to show vim-searchindex info in status bar

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

--=======================================--
--             Colorscheme resets        --
--=======================================--

-- Clear annoying todo highlights on non treesitter highlighted files, see: `:help highlights`
-- SEE: taken from https://vi.stackexchange.com/questions/14996/turn-off-syntax-hilighting-for-todo-items
-- SEE: taken from https://www.reddit.com/r/neovim/comments/106ia0r/need_help_in_fixing_signcolumns_grey/
-- This command should be executed before loading first color scheme to have effect on it.
vim.cmd("autocmd ColorScheme * highlight clear Todo") -- It must come before linking!
vim.cmd("autocmd ColorScheme * highlight link Todo Comment") -- usually Todo keywords are tied to comments!

--=======================================--
--               Title                   --
--=======================================--

-- Set the window to have the value of 'titlestring'
-- Good for using multiple terminal windows
-- and to switch to them using an app like Contexts on macos
-- or Rofi on Linux.
vim.opt.title = true

-- `titlestring` accepts the same info as `statusline`
-- TODO: Shor
-- SEE: taken from https://vi.stackexchange.com/questions/15046/get-directory-name-from-cwd-dirname-without-preceding-path
-- vim.opt.titlestring = "%{getcwd()}"
-- BUG: when using dirvish it shows `//` character twice.
vim.opt.titlestring = "%{substitute(getcwd(), '^.*/', '', '')}/%f"
