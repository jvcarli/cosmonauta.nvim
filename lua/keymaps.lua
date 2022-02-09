-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- TODO: move mappings to which-key.nvim configuration
-- TODO: include text explaining the difference between
-- nmap and nnoremap and so on
-- see: https://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping

-- =======================================--
--           Augroups and autocmd         --
-- =======================================--

-- Commands inside vim.cmd are coded with VIM SCRIPT
-- `augroups` and `autocommands` DO NOT have a lua interface yet,
-- so `vim.cmd` is still needed.
-- This is being worked on, see: https://github.com/neovim/neovim/pull/12378

-- =======================================--
--            Keymaps definition          --
-- =======================================--

-- `vim.keymap.set` is non-recursive by default, that means: `{ remap = false }` by default
-- see: `:h vim.keymap.set`

local map = vim.keymap.set
local installed_and_loaded = require("utils").installed_and_loaded

-- {{{ Vanilla Neovim

-- {{{ Leader key
-- Remap space as leader key
-- taken from defaults.nvim: https://github.com/mjlbach/defaults.nvim/blob/master/init.lua

-- IT WORKS IHA! <space> is leader and "\" char (default leader) works independetly
-- BUG: for some reason this produces conflicts with which-key.nvim, but it doesn't seem to affect anything
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--- }}}

-- Save file {{{
-- beware of:
-- https://unix.stackexchange.com/questions/72086/ctrl-s-hangs-the-terminal-emulator/72092#72092
-- https://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s

-- see: https://superuser.com/questions/88432/save-in-insert-mode-vim/88435
-- Adding <C-\> will prevent moving cursor one character left.
-- lua needs escaping for \ char, so in lua is <C-\\>

-- save file without leaving insert mode
-- vscode goes brrrrrrrrl
vim.cmd "inoremap <silent> <C-s> <C-\\><C-o>:w<CR>"

-- save file in normal mode
-- space before :w matters, but why??
vim.cmd "nnoremap <silent> <C-s> :w<CR>"

-- }}}

-- {{{ Move around buffers easily

-- see: http://andrewradev.com/2011/04/26/my-vim-workflow-basic-moves/
map("n", "gh", "<C-w>h", { remap = true })
map("n", "gj", "<C-w>j", { remap = true })
map("n", "gk", "<C-w>k", { remap = true })
map("n", "gl", "<C-w>l", { remap = true })

-- }}}

-- }}}

-- {{{ Thirdy-party plugins:

-- {{{ open-browser.vim

if installed_and_loaded "open-browser.vim" then
  -- openbrowser-smart-search:
  -- If it looks like URI open the URI under cursor.
  -- Otherwise, search the word under cursor

  map({ "n", "v" }, "gx", "<Plug>(openbrowser-smart-search)", { remap = true })
end

-- }}}

-- {{{ undotree

if installed_and_loaded "undotree" then
  map("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { silent = true })
end

-- }}}

-- {{{ telescope.nvim builtins

if installed_and_loaded "telescope.nvim" then
  map("n", "<leader><space>", "<cmd>Telescope buffers<CR>")

  map("n", "<leader>sf", "<cmd>Telescope find_files<CR>")

  map("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>")

  map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>") -- Neovim help tags

  map("n", "<leader>st", "<cmd>Telescope tags<CR>") -- universal ctags, see 'ludovicchabant/vim-gutentags' and 'universal-ctags/ctags'

  map("n", "<leader>sw", "<cmd>Telescope grep_string<CR>")

  map("n", "<leader>sg", "<cmd>Telescope live_grep<CR>")

  map("n", "<leader>so", "<cmd>Telescope tags<CR>")

  map("n", "<leader>?", "<cmd> Telescope oldfiles<CR>")
end

-- }}}

-- {{{ project.nvim

if installed_and_loaded then
  map("n", "<leader>sp", "<cmd>Telescope projects<CR>")
end

-- }}}

-- {{{ nvim-tree.lua

if installed_and_loaded "nvim-tree.lua" then
  map("n", "<leader>n", "<cmd>NvimTreeToggle<CR>")
end

-- }}}

-- {{{ vim-niceblock

if installed_and_loaded "vim-niceblock" then
  map("v", "I", "<Plug>(niceblock-I)", { remap = true })
  map("v", "gI", "<Plug>(niceblock-gI)", { remap = true })
  map("v", "A", "<Plug>(niceblock-A)", { remap = true })
end

-- }}}

-- {{{ zen-mode.nvim
if installed_and_loaded "zen-mode.nvim" then
  map("n", "<leader>zm", "<cmd>ZenMode<CR>")
end

-- }}}

-- vim-easy-align {{{

if installed_and_loaded "vim-easy-align" then
  -- Start interactive EasyAlign for a motion/text object (e.g.: glip)
  -- or in visual mode (e.g.: vipgl)
  -- DON'T use a normal mode mapping here
  -- because it will conflict with `gl` window movement mapping
  map("x", "gl", "<Plug>(EasyAlign)", { remap = true })
end

-- }}}

-- }}}

-- {{{ Thirdy-party apps (GUI / TUI / CLI ...)

-- {{{ Webstorm Ide integration

-- if webstorm cli is present in $PATH, do:
if vim.fn.executable "webstorm" == 1 then
  -- TODO: add and "if project is web related then", how to detect this?

  -- See: https://www.reddit.com/r/vim/comments/b2m2dp/move_from_ide_to_vim/
  -- See: https://stackoverflow.com/questions/4037984/is-it-possible-to-extend-intellij-such-that-i-can-open-the-current-file-in-vim
  -- See: https://vi.stackexchange.com/questions/18073/neovim-qt-is-it-possible-open-files-in-the-existing-window
  -- See: https://www.reddit.com/r/neovim/comments/nehuye/how_to_alternate_between_neovim_and_other_text/
  -- Opens Webstorm in the same line as nvim buffer. Column is not supported by webstorm cli.
  -- TODO: why this mapping / command blocks neovim after being executed?
  --
  -- viml original, that gets blocked in neovim too
  -- nnoremap <leader>iw :execute 'silent !webstorm --line '.line('.').' '.expand('%:p')\|redraw!<cr>

  map("n", "<leader>iw", "<cmd>execute 'silent !webstorm --line '.line('.').' '.expand('%:p')|redraw!<cr>")
end

-- }}}

-- }}}

-- }}}
