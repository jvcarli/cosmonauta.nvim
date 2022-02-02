-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- TODO: move mappings to which-key.nvim configuration

-- =======================================--
--           Augroups and autocmd         --
-- =======================================--

-- Commands inside vim.cmd are coded with VIM SCRIPT
-- because augroups and autocommands DO NOT have an interface yet,
-- This is being worked on, see: https://github.com/neovim/neovim/pull/12378

-- plugins with mappings
-- local plugins_with_maps = {
--   "open-browser.vim",
--   "undotree",
--   "incsearch.vim",
--   "telescope.nvim",
--   "nvim-tree.lua",
-- }

-- TODO: only load mappings when it's applicable
-- for _, plugin in pairs(plugins_with_maps) do
--   if packer_plugins[plugin] and packer_plugins[plugin].loaded then
--     print "Vim fugitive is loaded"
--   end
-- end

-- Vanilla vim
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

-- save file in normal mode, :w is for losers
-- space before :w matters, but why??
vim.cmd "nnoremap <silent> <C-s> :w<CR>"

-- }}}

-- Plugins:
-- {{{ openbrowser

-- ("n": normal mode, "v": visual mode)

vim.api.nvim_set_keymap("n", "gx", "<Plug>(openbrowser-smart-search)", { noremap = false })
vim.api.nvim_set_keymap("v", "gx", "<Plug>(openbrowser-smart-search)", { noremap = false })
--
-- }}}

-- {{{ Undotree

vim.api.nvim_set_keymap("n", "<leader>u", ":UndotreeToggle<CR>", { silent = true })

-- }}}

-- {{{ IncSearch

-- vim.api.nvim_set_keymap("n", "/", "<Plug>(incsearch-forward)", { noremap = false })
-- vim.api.nvim_set_keymap("n", "?", "<Plug>(incsearch-backward)", { noremap = false })
-- vim.api.nvim_set_keymap("n", "n", "<Plug>(incsearch-nohl-n)", { noremap = false })
-- vim.api.nvim_set_keymap("n", "N", "<Plug>(incsearch-nohl-N)", { noremap = false })
-- vim.api.nvim_set_keymap("n", "*", "<Plug>(incsearch-nohl-*)N", { noremap = false })
-- vim.api.nvim_set_keymap("n", "#", "<Plug>(incsearch-nohl-#)", { noremap = false })
-- vim.api.nvim_set_keymap("n", "g*", "<Plug>(incsearch-nohl-g*)N", { noremap = false })
-- vim.api.nvim_set_keymap("n", "g#", "<Plug>(incsearch-nohl-g#)", { noremap = false })

-- }}}

-- {{{ Telescope

vim.api.nvim_set_keymap(
  "n",
  "<leader><space>",
  [[<cmd>lua require('telescope.builtin').buffers()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sf",
  [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
  { noremap = true, silent = true }
)

-- TODO: make telescope start file_browser from $HOME directory
vim.api.nvim_set_keymap(
  "n",
  "<leader>sF",
  [[<cmd>lua require('telescope.builtin').file_browser()<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>sb",
  [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sh",
  [[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>st",
  [[<cmd>lua require('telescope.builtin').tags()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sw",
  [[<cmd>lua require('telescope.builtin').grep_string()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>sg",
  [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>so",
  [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>?",
  [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>sp", ":Telescope projects<CR>", { noremap = true, silent = true })

-- }}}

-- {{{ NvimTree

vim.api.nvim_set_keymap("n", "<leader>n", ":NvimTreeToggle<CR>", { silent = true })

-- }}}

-- {{{ Webstorm Ide integration

-- See: https://www.reddit.com/r/vim/comments/b2m2dp/move_from_ide_to_vim/
-- See: https://stackoverflow.com/questions/4037984/is-it-possible-to-extend-intellij-such-that-i-can-open-the-current-file-in-vim
-- See: https://vi.stackexchange.com/questions/18073/neovim-qt-is-it-possible-open-files-in-the-existing-window
-- See: https://www.reddit.com/r/neovim/comments/nehuye/how_to_alternate_between_neovim_and_other_text/
-- Opens Webstorm in the same line as nvim buffer. Column is not supported by webstorm cli.
-- TODO: why this mapping / command blocks neovim after being executed?
--
-- viml original, that gets blocked in neovim too
-- nnoremap <leader>iw :execute 'silent !webstorm --line '.line('.').' '.expand('%:p')\|redraw!<cr>

vim.api.nvim_set_keymap(
  "n",
  "<leader>iw",
  ":execute 'silent !webstorm --line '.line('.').' '.expand('%:p')|redraw!<cr>",
  { noremap = false, silent = true }
)
-- TODO: noremap should be false or true?
-- TODO: silent should be false or true?

-- }}}

-- {{{ Niceblock
vim.api.nvim_set_keymap("v", "I", "<Plug>(niceblock-I)", { noremap = false })
vim.api.nvim_set_keymap("v", "gI", "<Plug>(niceblock-gI)", { noremap = false })
vim.api.nvim_set_keymap("v", "A", "<Plug>(niceblock-A)", { noremap = false })
-- }}}

-- {{{ Hop
vim.api.nvim_set_keymap("n", "<leader>ow", "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>or", "<cmd>lua require'hop'.hint_lines()<cr>", {})
-- }}}

-- {{{ Folke zen mode
vim.api.nvim_set_keymap("n", "<leader>zm", "<cmd>ZenMode<CR>", { noremap = true, silent = true })
-- }}}

-- EasyAlign {{{

-- Start interactive EasyAlign in visual mode (e.g. vipga)
vim.cmd "xmap gl <Plug>(EasyAlign)"

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.cmd "nmap gl <Plug>(EasyAlign)"

-- }}}
