-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- TODO: move mappings to which-key.nvim configuration

-- =======================================--
--           Augroups and autocmd         --
-- =======================================--

-- Commands inside vim.cmd are coded with VIM SCRIPT
-- `augroups` and `autocommands` DO NOT have a lua interface yet,
-- so `vim.cmd` is still needed.
-- This is being worked on, see: https://github.com/neovim/neovim/pull/12378

-- checks if plugin is installed and loaded by packer
local installed_and_loaded = function(plugin)
  return packer_plugins[plugin] and packer_plugins[plugin].loaded
end

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

-- {{{ Thirdy-party plugins:

-- {{{ open-browser.vim

if installed_and_loaded "open-browser.vim" then
  -- openbrowser-smart-search:
  -- If it looks like URI open the URI under cursor.
  -- Otherwise, search the word under cursor

  vim.keymap.set({ "n", "v" }, "gx", "<Plug>(openbrowser-smart-search)", { remap = true })
end

-- }}}

-- {{{ undotree

if installed_and_loaded "undotree" then
  vim.api.nvim_set_keymap("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { silent = true })
end

-- }}}

-- {{{ telescope.nvim

if installed_and_loaded "telescope.nvim" then
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
end

-- }}}

-- {{{ nvim-tree.lua

if installed_and_loaded "nvim-tree.lua" then
  vim.api.nvim_set_keymap("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", { silent = true })
end

-- }}}

-- {{{ vim-niceblock

if installed_and_loaded "vim-niceblock" then
  vim.keymap.set("v", "I", "<Plug>(niceblock-I)", { remap = true })
  vim.keymap.set("v", "gI", "<Plug>(niceblock-gI)", { remap = true })
  vim.keymap.set("v", "A", "<Plug>(niceblock-A)", { remap = true })
end

-- }}}

-- {{{ zen-mode.nvim
if installed_and_loaded "zen-mode.nvim" then
  vim.keymap.set("n", "<leader>zm", "<cmd>ZenMode<CR>", { remap = false, silent = true })
end

-- }}}

-- vim-easy-align {{{

if installed_and_loaded "vim-easy-align" then
  -- Start interactive EasyAlign for a motion/text object (e.g.: glip)
  -- or in visual mode (e.g.: vipgl)
  vim.keymap.set({ --[[ "n", ]]
    "x",
  }, "gl", "<Plug>(EasyAlign)", { remap = true })
end

-- }}}

-- }}}

-- {{{ Thirdy-party apps/cli

-- {{{ Webstorm Ide integration

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.cmd "nmap gl <Plug>(EasyAlign)"

-- }}}
