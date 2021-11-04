-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- {{{ Leader key

-- Remap space as leader key
-- See: https://neovim.discourse.group/t/the-300-line-init-lua-challenge/227
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- }}}

-- {{{ CmdlineComplete
-- TODO: add CmdlineComplete shortcuts
-- https://github.com/vim-scripts/CmdlineComplete
-- https://www.vim.org/scripts/script.php?script_id=2222
-- If you want to use other keys instead of default <c-p> <c-n>, you may say in your .vimrc
-- cmap <c-y> <Plug>CmdlineCompleteBackward
-- cmap <c-e> <Plug>CmdlineCompleteForward
-- this will use Ctrl-Y for search backward and Ctrl-E for forward search
--
-- Note: I don't think it's good to use Tab and Shift-Tab for completion, since it will disable vim's original cmdline-completion.
-- }}}

-- {{{ Trouble.nvim
-- https://github.com/folke/trouble.nvim
vim.api.nvim_set_keymap("n", "<leader>td", "<cmd>TroubleToggle<CR>", {noremap = true, silent = true})
-- }}}

-- {{{ folke/todo-comments
-- has integration with folke/trouble
vim.api.nvim_set_keymap("n", "<leader>tta", "<cmd>TroubleToggle Todo<CR>", {noremap = true, silent = true})
--
vim.api.nvim_set_keymap("n", "<leader>ttq", "<cmd>TodoQuickFix<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tts", "<cmd>TodoTelescope<CR>", {noremap = true, silent = true})

-- }}}

-- {{{ Folke zen mode
vim.api.nvim_set_keymap("n", "<leader>z", "<cmd>ZenMode<CR>", {noremap = true, silent = true})
-- }}}

-- {{{ openbrowser
-- ("n": normal mode, "v": visual mode)
vim.api.nvim_set_keymap("n", "gx", "<Plug>(openbrowser-smart-search)", {noremap = false})
vim.api.nvim_set_keymap("v", "gx", "<Plug>(openbrowser-smart-search)", {noremap = false})
--
-- }}}

-- {{{ Barbar
--  Move to previous/next
vim.api.nvim_set_keymap("n", "<A-,>", ":BufferPrevious<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "[b", ":BufferPrevious<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-.>", ":BufferNext<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "]b", ":BufferNext<CR>", { noremap=true, silent = true })

--  Re-order to previous/next
-- TODO: remap kitty shortcuts that are conflicting with this
vim.api.nvim_set_keymap("n", "<A-<>", ":BufferMovePrevious<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A->>", ":BufferMoveNext<CR>", {silent = true} )

-- Close buffer
vim.api.nvim_set_keymap("n", "<A-w>", ":BufferClose<CR>", {silent = true} )

-- Goto buffer in position...
vim.api.nvim_set_keymap("n", "<A-1>", ":BufferGoto 1<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-2>", ":BufferGoto 2<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-3>", ":BufferGoto 3<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-4>", ":BufferGoto 4<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-5>", ":BufferGoto 5<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-6>", ":BufferGoto 6<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-7>", ":BufferGoto 7<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-8>", ":BufferGoto 8<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-9>", ":BufferGoto 9<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-0>", ":BufferLast<CR>", {silent = true})

-- nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
-- nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>

-- }}}

-- {{{ Undotree

vim.api.nvim_set_keymap("n", "<leader>u", ":UndotreeToggle<CR>", {silent=true})

-- }}}

-- {{{ nvim dap

-- vim.api.nvim_set_keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", {silent = true})

-- vim.api.nvim_set_keymap("n", "<leader>dd", ":lua require('dap').continue()<CR>" ,{silent = true})

-- vim.api.nvim_set_keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>" ,{silent = true})

-- vim.api.nvim_set_keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>" ,{silent = true})

-- vim.api.nvim_set_keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>" ,{silent = true})

-- vim.api.nvim_set_keymap("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>",{silent = true})

-- vim.api.nvim_set_keymap("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" ,{silent = true})

-- vim.api.nvim_set_keymap("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",{silent = true})

-- vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", {silent = true})

-- vim.api.nvim_set_keymap("n", "<leader>dl", ":lua require'dap'.repl.run_last()<CR>`" ,{silent = true})

-- vim.api.nvim_set_keymap("n", "<leader>dn", ":lua require('dap-python').test_method()<CR>" ,{silent = true})

-- vim.api.nvim_set_keymap("v", "<leader>ds", "<ESC>:lua require('dap-python').debug_selection()<CR>", {silent = true})

--}}}

-- {{{ vim-telescope

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", {silent=true})
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", {silent=true})
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", {silent=true})
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", {silent=true})
vim.api.nvim_set_keymap("n", "<leader>ft", "<cmd>lua require('telescope.builtin').treesitter()<CR>", {silent=true})

-- }}}

-- {{{ Hop.nvim

vim.api.nvim_set_keymap('n', 'sw', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('n', 'sp', "<cmd>lua require'hop'.hint_patterns()<cr>", {})
vim.api.nvim_set_keymap('n', 'sc', "<cmd>lua require'hop'.hint_char1()<cr>", {})
vim.api.nvim_set_keymap('n', 'sk', "<cmd>lua require'hop'.hint_char2()<cr>", {})
vim.api.nvim_set_keymap('n', 'sl', "<cmd>lua require'hop'.hint_lines()<cr>", {})

-- }}}

-- {{{ Yank

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})

-- }}}

-- {{{ nvim-lsp

vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {silent=true})

-- }}}

-- {{{ vim-fugitive

-- Gedit
vim.api.nvim_set_keymap("n", "<leader>ge", "<cmd>Gedit :<CR>", {noremap = true, silent = true})

-- Diffview
vim.api.nvim_set_keymap("n", "<leader>gdv", "<cmd>Gvdiffsplit :<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>gdh", "<cmd>Gdiffsplit :<CR>", {noremap = true, silent = true})

-- }}}

-- TODO: add command to toggle `:nohlsearch`
-- there's one plugin that enhances hlsearch and solves this
-- this will remove the highlighting of searched matches

-- TODO: integrate awesome wm - for when working on linux
-- see: https://github.com/intrntbrn/awesomewm-vim-tmux-navigator

-- TODO: make a list of all plugins keymaps in this folder and return it below:

-- local keymap_files = {"vim-fugitive"}

-- for _, file in pairs(keymap_files) do
--     -- TODO: if file different than init, require it
--     -- if file ~= "init.lua" then
--     --   -- do something
--     -- return require(file)
--     --   break
--     -- end
--     return require(file)
-- end
