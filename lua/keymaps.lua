-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- TODO: include text explaining the difference between
-- different types of mappings
-- see: https://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping

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
  map("n", "<leader>sl", "<cmd>Telescope buffers<CR>")

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

-- {{{ nvim-lspconfig

local lsp_keymaps = function(bufnr)
  -- TODO: include more client._ checking conditions
  -- such as: if `client.resolved_capabilities.document_formatting then ... `
  -- to ensure null-ls and lspconfig are defining keymaps when they are applicable

  -- Uses LSP as the handler for Neovim built-in omnifunc (i_CTRL-X_CTRL-O)
  -- DISABLED in favor of nvim_cmp autocompletion plugin
  -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  -- These mappings only work inside a buffer with a LSP attached
  -- which is good because it won't affect default mappings when there isn't a LSP

  local opts = { remap = false, silent = true, buffer = bufnr }
  -- TODO: `buffer = bufnr` and `buffer = 0` seems in practice to mean the same thing
  -- find out if there's any difference
  -- buffer: means buffer handle
  -- buffer = bufnr makes it so the mapping will apply only for the buffer where there's a lsp attached

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

  -- Hover and help
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

  -- Workspace management
  -- TODO: explore lsp workspace management and how it works
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)

  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("v", "<leader>ca", vim.lsp.buf.range_code_action, opts)

  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.lsp.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.lsp.diagnostic.goto_next, opts)

  -- load and show diagnostics in Neovim location list
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

  vim.keymap.set("n", "<leader>so", function()
    return require("telescope.builtin").lsp_document_symbols()
  end, opts)
end

-- }}}

-- {{{ Thirdy-party apps (GUI / TUI / CLI ...)

-- {{{ Webstorm Ide integration

-- if webstorm cli is present in $PATH, do:
if vim.fn.executable "webstorm" == 1 then
  -- TODO: realtime sync terminal Neovim with Webstorm. Is it possible?
  -- TODO: add and "if project is web related then", how to detect this?

  -- See: https://www.reddit.com/r/vim/comments/b2m2dp/move_from_ide_to_vim/
  -- See: https://stackoverflow.com/questions/4037984/is-it-possible-to-extend-intellij-such-that-i-can-open-the-current-file-in-vim
  -- See: https://vi.stackexchange.com/questions/18073/neovim-qt-is-it-possible-open-files-in-the-existing-window

  -- BUG: if Webstorm isn't already opened, Neovim spawns a new process that blocks
  --      the current buffer from being editing (cursor won't move), no matter if
  --      using light edit or not. Is this webstorm cli intended behavior?
  --      Maybe use plenary for launching it asynchronously?
  --      If webstorm was already launched the buffer won't be blocked.
  --        WORKAROUND: This is overcome by using `setsid`, but is a LINUX ONLY solution
  --        see: https://github.com/justinmk/vim-gtfo/issues/50
  --        TODO: see if the same problem happens in macOS

  -- Open the whole project in Webstorm
  -- and the current file in current cursor position (Webstorm intelligently guesses the project root)
  map(
    "n",
    "gowp",
    -- setsid tip taken from: https://github.com/justinmk/vim-gtfo/issues/50
    [[<cmd>execute 'silent !setsid webstorm --line ' . line('.') . ' --column ' . col('.') . ' ' . expand('%:p')<CR>]]
  )

  -- Open only current file in Webstorm (without its project) in current cursor position.
  -- Possible only when using early 2020 releases or later.
  -- This uses the IDE lightedit mode. see: https://blog.jetbrains.com/idea/2020/04/lightedit-mode/
  -- `$ westorm -e <file-to-be-light-edited>`
  -- NOTE: for now lightedit mode doesn't support opening files using `--line` and `--column` parameters
  map("n", "gowf", [[<cmd>execute 'silent !setsid webstorm -e ' . expand('%:p')<CR>]])

  -- NOTE: From Webstorm it is possible to go back to terminal Neovim in the same instance and buffer
  -- using IdeaVim plugin and a mapping defined in the $XDG_CONFIG_HOME/ideavim/ideavimrc file (.vimrc analog)
  -- This mapping triggers a custom external tool defined in:
  -- Preferences > Tools > External tools
  -- The tool uses nvr cli (see: https://github.com/mhinz/neovim-remote)
  -- See: https://www.reddit.com/r/neovim/comments/nehuye/how_to_alternate_between_neovim_and_other_text/
  -- See: https://www.reddit.com/r/IntelliJIDEA/comments/dphwrd/how_to_configure_ideavim_shortcut_to_open_file_in/
end

-- }}}

-- {{{ Vscode integration

-- if Vscode cli (code) is present in $PATH, do:
if vim.fn.executable "code" == 1 then
  -- TODO: realtime sync terminal Neovim with Vscode. Is it possible?

  -- Open the whole project in Vscode
  -- and the current file in current cursor position (it assumes cwd will be project root).
  -- I'm using project.nvim for automatically setting the project root. (vim-rooter can be used too)
  -- Vscode spawns correctly as an external process.
  map(
    "n",
    "gocp",
    [[<cmd>execute 'silent !code ' . getcwd() . ' -g ' . expand('%:p') . ':' . line('.') . ':' . col('.') <CR>]]
  )

  -- Open only current file in Vscode (without its project) in current cursor position.
  map("n", "gocf", [[<cmd>execute 'silent !code -g ' . expand('%:p') . ':' . line('.') . ':' . col('.') <CR>]])

  -- NOTE: From Vscode it is possible to go back to terminal Neovim in the same instance and buffer
  -- a mapping defined in ~/.config/nvim/vscode/lua/keymaps.lua
  -- This mapping triggers nvr cli (see: https://github.com/mhinz/neovim-remote):
  -- See: https://www.reddit.com/r/neovim/comments/nehuye/how_to_alternate_between_neovim_and_other_text/
end

-- }}}

-- }}}
