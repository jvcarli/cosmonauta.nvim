-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

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
-- Toggle Trouble with `Leader > e` keys
-- vim.api.nvim_set_keymap("n", "<leader>tc", "<cmd>TroubleToggle<CR>", {noremap = true, silent = true}) -- redundant
vim.api.nvim_set_keymap("n", "<leader>tw", "<cmd>LspTroubleWorkspaceToggle<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>td", "<cmd>LspTroubleDocumentToggle<CR>", {noremap = true, silent = true})


-- folke/todo-comments
-- has integration with folke/trouble
-- see: https://github.com/folke/todo-comments.nvim
vim.api.nvim_set_keymap("n", "<leader>tta", "<cmd>TroubleToggle Todo<CR>", {noremap = true, silent = true})
--
vim.api.nvim_set_keymap("n", "<leader>ttq", "<cmd>TodoQuickFix<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tts", "<cmd>TodoTelescope<CR>", {noremap = true, silent = true})

-- }}}

-- {{{ openbrowser ("n": normal mode, "v": visual mode)
vim.api.nvim_set_keymap("n", "gx", "<Plug>(openbrowser-smart-search)", {noremap = false})
vim.api.nvim_set_keymap("v", "gx", "<Plug>(openbrowser-smart-search)", {noremap = false})
-- }}}

-- {{{ sneakvim
-- See: https://www.reddit.com/r/neovim/comments/jwd0qx/how_do_i_define_vim_variable_in_lua/
vim.g["sneak#label"] = 1
-- }}}

-- {{{ Barbar
--  Move to previous/next
vim.api.nvim_set_keymap("n", "<A-,>", ":BufferPrevious<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "<A-.>", ":BufferNext<CR>", {silent = true} )
vim.api.nvim_set_keymap("n", "[b", ":BufferNext<CR>", { noremap=true, silent = true })

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

-- vim-lineletters {{{

-- On NORMAL mode comma character default beahivor is to
-- repeat latest f, t, F or T in opposite direction.
-- In practice this is awkward to use.
-- Quick-scope plugin provides a better experience
-- for this type of motion, so comma will be overrided
--
-- vim script syntax: map <silent>, <Plug>LineLetters
vim.api.nvim_set_keymap("n", ",", "<Plug>LineLetters", {silent = true})

-- }}}

-- {{{ nvim dap

vim.api.nvim_set_keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", {silent = true})

vim.api.nvim_set_keymap("n", "<leader>dd", ":lua require('dap').continue()<CR>" ,{silent = true})

vim.api.nvim_set_keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>" ,{silent = true})

vim.api.nvim_set_keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>" ,{silent = true})

vim.api.nvim_set_keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>" ,{silent = true})

vim.api.nvim_set_keymap("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>",{silent = true})

vim.api.nvim_set_keymap("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" ,{silent = true})

vim.api.nvim_set_keymap("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",{silent = true})

vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", {silent = true})

vim.api.nvim_set_keymap("n", "<leader>dl", ":lua require'dap'.repl.run_last()<CR>`" ,{silent = true})

vim.api.nvim_set_keymap("n", "<leader>dn", ":lua require('dap-python').test_method()<CR>" ,{silent = true})

vim.api.nvim_set_keymap("v", "<leader>ds", "<ESC>:lua require('dap-python').debug_selection()<CR>", {silent = true})

--}}}

-- {{{ vim-telescope

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", {silent=true})
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", {silent=true})
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", {silent=true})
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", {silent=true})
vim.api.nvim_set_keymap("n", "<leader>ft", "<cmd>lua require('telescope.builtin').treesitter()<CR>", {silent=true})

-- }}}

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})

-- TODO: add command to toggle `:nohlsearch`
-- there's one plugin that enhances hlsearch and solves this
-- this will remove the highlighting of searched matches

-- TODO: integrate awesome wm - for when working on linux
-- see: https://github.com/intrntbrn/awesomewm-vim-tmux-navigator

