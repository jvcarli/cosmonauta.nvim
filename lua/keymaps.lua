-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- TODO: include text explaining the difference between
-- different types of mappings
-- SEE: https://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping

-- =======================================--
--            Keymaps definition          --
-- =======================================--

-- TODO: explore localleader mappings
-- TODO: https://stackoverflow.com/questions/1506764/how-to-map-ctrla-and-ctrlshifta-differently

-- `vim.keymap.set` is non-recursive by default, that means: `{ remap = false }` by default
-- SEE: `:h vim.keymap.set`

-- SEE: Give arguments to mappings
--      https://www.reddit.com/r/neovim/comments/sjiwox/question_give_arguments_to_vimkeymapsets_function/

local map = vim.keymap.set
local is_mac = require("user.modules.utils").is_mac
local is_linux = require("user.modules.utils").is_linux

local M = {}

-- {{{ Vanilla Neovim

-- Save file {{{
-- beware of:
-- https://unix.stackexchange.com/questions/72086/ctrl-s-hangs-the-terminal-emulator/72092#72092
-- https://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s

-- SEE: https://superuser.com/questions/88432/save-in-insert-mode-vim/88435
-- Adding <C-\> will prevent moving cursor one character left.
-- lua needs escaping for \ char, so in lua is <C-\\>

-- SEE: https://vim.fandom.com/wiki/Quick_save
-- save file without leaving insert mode
-- vscode goes brrrrrrrrl
vim.cmd "inoremap <silent> <C-s> <C-\\><C-o>:update<CR>"

-- save file in normal mode
-- space before :update matters, but why??
-- BUG: for some reason in doesn't work if is the very first command you enter
--      when starting a new `$nvim` session.
vim.cmd "nnoremap <silent> <C-s> :update<CR>"

-- }}}

-- {{{ Set intelligent undo breakpoints

-- TODO: set additional undo breakpoints for latex in a proper ftplugin file
-- Sets undo breaking points every time a comma, period, question or exclamation mark
-- is placed when in insert mode.
-- taken from ThePrimeagen: https://youtu.be/hSHATqh8svM?t=238

map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", ":", ":<c-g>u")

-- }}}

-- {{{ Window splits

-- Enhance default vim split mappings
--   <C-w>v: vsplit respecting current splitright option. I use splitright
--   <C-w>s: split respecting current splitbelow option. I use splitbelow

map("n", "<C-w>V", "<cmd>set nosplitright | vsplit | set splitright<CR>", { silent = true }) -- force split window to the left
map("n", "<C-w>S", "<cmd>set nosplitbelow | split | set splitbelow<CR>", { silent = true }) -- force split window to the top

-- }}}

-- {{{ Tabs

-- TODO: integrate lualine tab rename (<cmd>LualineRenameTab)
-- map("n", "<leader>tr", "<cmd>tabnew<CR>") -- open a new tab

map("n", "<leader>tn", "<cmd>tabnew<CR>") -- open a new tab

-- }}}

-- {{{ Better join line (J key)

-- makes J go where the cursor was before using it
-- SEE: Inspired by https://stackoverflow.com/questions/9505198/join-two-lines-in-vim-without-moving-the-cursor
-- SEE:             https://youtu.be/hSHATqh8svM?t=238
local function better_join_line()
  local current_cursor_pos = vim.fn.getpos "."
  vim.cmd "join"
  return vim.fn.setpos(".", current_cursor_pos)
end

map("n", "J", better_join_line)

-- }}}

-- {{{ Source init.lua

-- TODO: how to make this mapping work?
-- map("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/init.lua<CR>")

-- }}}

-- Clipboard yanking {{{

map({ "n", "v" }, "<leader>y", '"+y') -- yank to quoteplus "+" register (System clipboard)

-- }}}

-- {{{ Command line pasting

-- Inside Neovim i'm using the selection clipboard ('*' register)
-- Paste content from SYSTEM clipboard ('+' register)
-- TODO: I think this differ between macos and Linux
map("c", "<C-v>", "<C-r>+")

-- }}}

-- {{{ Plugin development

-- source files without leaving neovim
local src_current_file = function()
  if vim.bo.filetype == ("vim" or "lua") then
    vim.cmd "write"
    vim.cmd "source %" -- can use luafile for lua, but source is now supported too
  end
end

map("n", "<leader>ze", src_current_file, { silent = false })

-- }}}

-- NOTE: testing:
-- taken from: https://github.com/torgeir/vim/blob/master/keybindings.vim#L13-L17
-- " don't exit visual mode when shifting
map("v", "<", "<gv2h")
map("v", ">", ">gv2h")

-- vnoremap <c-h> <gv2h
-- vnoremap <c-l> >gv2l

-- Auto indent on empty line.
-- taken from: https://www.reddit.com/r/neovim/comments/td4p3b/wrong_indent_on_insert/
-- vim.keymap.set("n", "i", function()
--   return string.match(vim.api.nvim_get_current_line(), "%g") == nil and "cc" or "i"
-- end, { expr = true, noremap = true })

-- test
-- taken from: https://github.com/torgeir/vim/blob/master/keybindings.vim#L13-L17
-- " skip to { and }
-- map [[ ?\{<CR>w99[{
-- map ][ /\}<CR>b99]}
-- map ]] j0[[%/\{<CR>
-- map [] k$][%?\}<CR>

-- {{{ Less cluttered <C-g>

local cleaned_current_filepath = require("user.modules.utils").cleaned_current_filepath

-- Just like 1<C-g> behavior but with a cleaner output.
-- This is great for buffers that have crowded names, such as fugitive ones.
-- TODO: include color highlights (make the file name bold)
--       SEE: https://vi.stackexchange.com/questions/26278/how-to-change-the-command-line-status-message-color-and-font
map("n", "<C-g>f", cleaned_current_filepath)

-- }}}

-- {{{ Print working directory

local cleaned_current_working_dir = require("user.modules.utils").cleaned_current_working_dir
map("n", "<C-g>d", cleaned_current_working_dir)

-- }}}

-- {{{ Replace shortcut
-- TODO: convert to lua

-- Replace word under the cursor
-- TODO: remember cursor position
vim.cmd [[nnoremap <Leader>rw :%s/\<<C-r>=expand("<cword>")<CR>\>/]]
-- }}}

-- Neovim embeded terminal mappings {{{

-- WARN: needs a terminal emulator that interprets <Esc> and <C-[> differently
--       such as Kitty.
-- terminal remaps for zsh-vi-mode
-- escape to nvim normal mode
vim.cmd "tnoremap <Esc> <C-\\><C-n>"

-- escape to <Esc> which will go to zsh-vi-mode
vim.cmd "tnoremap <C-[> <Esc>"

-- }}}

-- {{{ fast-macros

-- makes macro execution faster
-- SEE: taken from https://www.reddit.com/r/neovim/comments/tsol2n/why_macros_are_so_slow_compared_to_emacs/

vim.cmd [[nnoremap @ <cmd>execute "noautocmd norm! " . v:count1 . "@" . getcharstr()<cr>]]
vim.cmd [[xnoremap @ :<C-U>execute "noautocmd '<,'>norm! " . v:count1 . "@" . getcharstr()]]

-- }}}

-- }}}

-- {{{ Thirdy-party (Neo)vim plugins:

-- {{{ open-browser.vim

-- openbrowser-smart-search:
-- If it looks like URI open the URI under cursor.
-- Otherwise, search the word under cursor

map({ "n", "v" }, "gxg", "<Plug>(openbrowser-smart-search)", { remap = true })

-- }}}

-- {{{ undotree

map("n", "<leader>uf", "<cmd>UndotreeToggle<CR>", { silent = true })

-- }}}

-- {{{ telescope.nvim builtins

-- TODO: implement mapping for Telescope git files

map("n", "<leader>sl", "<cmd>Telescope buffers<CR>")

map("n", "<leader>sf", "<cmd>Telescope find_files<CR>")

map("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>")

map("n", "<leader>sv", "<cmd>Telescope help_tags<CR>") -- Neovim help tags

-- open project tags (universal-ctags)
-- autogenerated using 'ludovicchabant/vim-gutentags' (it uses 'universal-ctags/ctags')
map("n", "<leader>stp", "<cmd>Telescope tags<CR>")

map("n", "<leader>stb", "<cmd>Telescope current_buffer_tags<CR>")

map("n", "<leader>sw", "<cmd>Telescope grep_string<CR>")

map("n", "<leader>sg", "<cmd>Telescope live_grep<CR>")

map("n", "<leader>?", "<cmd> Telescope oldfiles<CR>")

map("n", "<leader>sr", "<cmd> Telescope resume<CR>")

-- }}}

-- {{{ telescope custom thirdy party pickers

-- git_worktree.nvim
map("n", "<leader>sk", function()
  return require("telescope").extensions.git_worktree.git_worktrees()
  -- <Enter> - switches to that worktree
  -- <c-d> - deletes that worktree
  -- <c-f> - toggles forcing of the next deletion
end)

-- harpoon
map("n", "<leader>sh", "<cmd>Telescope harpoon marks<CR>")

-- nvim-neoclip.lua
map("n", ",c", "<cmd>Telescope neoclip<CR>")

-- }}}

-- {{{ telescope custom built pickers

-- color picker that syncs kitty color with nvim
map("n", "<leader>sc", function()
  return require("user.modules.colorscheme").telescope_color_picker()
end)

-- }}}

-- {{{ telescope-project.nvim

map("n", "<leader>sp", "<cmd>Telescope project<CR>")

-- }}}

-- {{{ vim-niceblock

map("v", "I", "<Plug>(niceblock-I)", { remap = true })
map("v", "gI", "<Plug>(niceblock-gI)", { remap = true })
map("v", "A", "<Plug>(niceblock-A)", { remap = true })

-- }}}

-- {{{ zen-mode.nvim
map("n", "<leader>zm", "<cmd>ZenMode<CR>")

-- }}}

-- vim-easy-align {{{

-- Start interactive EasyAlign for a motion/text object (e.g.: glip)
-- or in visual mode (e.g.: vipgl)
map({ "n", "x" }, "gl", "<Plug>(EasyAlign)", { remap = true })

-- }}}

-- {{{ nvim-lspconfig

-- TODO: implement keymap fallbacks
-- SEE: https://www.reddit.com/r/neovim/comments/tfna67/lsp_goto_definition_fallback_to_builtin_gd/
M.lsp_keymaps = function(client, bufnr)
  -- TODO: include more client._ checking conditions
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

  -- if client.server_capabilities.goto_definition then
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  -- end

  -- TODO: implement the same logic as above here:
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

  -- TODO: find alternative, gi vim default is useful and I don't want to change it
  -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

  -- Hover and help
  -- WARN: find a better key than K, because of cpp
  -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  -- TODO: use a signature plugin
  -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

  -- Workspace management
  -- TODO: explore lsp workspace management and how it works
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)

  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "gor", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

  -- TODO: fix the mapping. nvim 0.9 api change? yes, but i don't know the fix
  -- vim.keymap.set("v", "<leader>ca", vim.lsp.buf.range_code_action, opts)

  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- api changed
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- api changed

  -- load and show diagnostics in Neovim location list
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

  vim.keymap.set("n", "<leader>so", function()
    return require("telescope.builtin").lsp_document_symbols()
  end, opts)
end

-- }}}

-- {{{ refactoring.nvim
-- Remaps for each of the four debug operations currently offered by the plugin
vim.api.nvim_set_keymap(
  "v",
  "<Leader>re",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
  { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
  "v",
  "<Leader>rf",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
  { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
  "v",
  "<Leader>rv",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
  { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
  "v",
  "<Leader>ri",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  { noremap = true, silent = true, expr = false }
)

-- }}}

-- {{{ lightspeed.nvim

-- override default motions as i'm using clever-f plugin
-- which make these motions unnecesssary
map("n", ";", "<Plug>Lightspeed_omni_s", { remap = true })
-- map("n", "S", "<Plug>Lightspeed_omni_gs", { remap = true })
-- }}}

-- {{{ leap.nvim

map("n", "s", "<Plug>(leap-forward-to)", { remap = true })
map("n", "S", "<Plug>(leap-backward-to)", { remap = true })
map("n", ",w", "<Plug>(leap-from-window)", { remap = true })

-- }}}

-- {{{ gitsigns.nvim

M.gitsigns_mappings = function(bufnr)
  local gs = package.loaded.gitsigns

  -- Actions
  vim.keymap.set("n", "<leader>gd", gs.toggle_deleted, { buffer = bufnr })
  -- unimpaired.vim like toggle mapping
  vim.keymap.set("n", "yog", gs.toggle_signs, { buffer = bufnr })
end
-- }}}

-- {{{ DAP

map("n", "<Leader>dsc", ":lua require('dap').continue()<CR>")
map("n", "<Leader>dsv", ":lua require('dap').step_over()<CR>")
map("n", "<Leader>dsi", ":lua require('dap').step_into()<CR>")
map("n", "<Leader>dso", ":lua require('dap').step_out()<CR>")

map("n", "<Leader>dhh", ":lua require('dap.ui.variables').hover()<CR>")
map("v", "<Leader>dhv", ":lua require('dap.ui.variables').visual_hover()<CR>")

map("n", "<Leader>duh", ":lua require('dap.ui.widgets').hover()<CR>")
map("n", "<Leader>duf", ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>")

map("n", "<Leader>dro", ":lua require('dap').repl.open()<CR>")
map("n", "<Leader>drl", ":lua require('dap').repl.run_last()<CR>")

map("n", "<Leader>dbc", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<Leader>dbm", ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>")
map("n", "<Leader>dbt", ":lua require('dap').toggle_breakpoint()<CR>")

map("n", "<Leader>dc", ":lua require('dap.ui.variables').scopes()<CR>")
map("n", "<Leader>di", ":lua require('dapui').toggle()<CR>")

-- }}}

-- {{{ dirvish.vim

map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- local dirvish_cmd = function()
--   local cwd = vim.fn.getcwd()
--   vim.cmd("Dirvish " .. cwd)
-- end
-- map("n", "_", dirvish_cmd)

-- }}}

-- {{{ vim-dirvinist
-- dirvish.vim plugin for showing vim-projectionist projections
map("n", "+", "<cmd>Dirvinist<CR>")

--   map("n", "_", "<cmd>Neotree position=current<CR>")
-- }}}

-- {{{ fugitive.vim

--   map("x", "<leader>dp", "<cmd>diffput<CR>")
--
-- }}}

-- {{{ vim-searchindex

-- Center searched item (N/n)

-- " Inspiration from https://youtu.be/hSHATqh8svM?t=85
-- " Make every search centered
-- vim.cmd "nmap <silent> n nzzzv<Plug>SearchIndex"
-- vim.cmd "nmap <silent> N Nzzzv<Plug>SearchIndex"
vim.cmd "nmap <silent> n nzzzv"
vim.cmd "nmap <silent> N Nzzzv"

-- }}}

-- {{{ mark.vim (highlighting plugin)

map({ "n", "x" }, "H", "<Plug>MarkSet", { remap = true })
map("n", "<leader>H", "<Plug>MarkClear", { remap = true })

-- }}}

-- {{{ vim-matchup

map("n", "<c-g>w", "<cmd>MatchupWhereAmI<CR>")

-- }}}

-- {{{ harpoon.nvim

map("n", ",s", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")
map("n", ",r", "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>")
map("n", ",a", "<cmd>lua require('harpoon.mark').add_file()<CR>")

-- }}}

-- {{{ sniprun
map({ "n", "v" }, ",e", "<cmd>SnipRun<CR>")
-- }}}

-- {{{ bufsurf.vim

-- WARN: this mapping conflicts with tpope/vim-unimpaired
map("n", "]b", "<Plug>(buf-surf-forward)")
map("n", "[b", "<Plug>(buf-surf-back)")

-- }}}

-- {{{ GitJump

-- NOTE: see commands.lua
vim.cmd [[ nnoremap <leader>gj :GitJump<space>]]

-- }}}

-- {{{ cmdbuf.nvim

vim.keymap.set("n", "q;", function()
  require("cmdbuf").split_open(vim.o.cmdwinheight)
end)
vim.keymap.set("c", "<C-f>", function()
  require("cmdbuf").split_open(vim.o.cmdwinheight, { line = vim.fn.getcmdline(), column = vim.fn.getcmdpos() })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "n", true)
end)

-- Custom buffer mappings
vim.api.nvim_create_autocmd({ "User" }, {
  group = vim.api.nvim_create_augroup("cmdbuf_setting", {}),
  pattern = { "CmdbufNew" },
  callback = function()
    vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { nowait = true, buffer = true })
    vim.keymap.set("n", "dd", [[<Cmd>lua require('cmdbuf').delete()<CR>]], { buffer = true })
  end,
})

-- open lua command-line window
vim.keymap.set("n", "ql", function()
  require("cmdbuf").split_open(vim.o.cmdwinheight, { type = "lua/cmd" })
end)

-- q/, q? alternative
vim.keymap.set("n", "q/", function()
  require("cmdbuf").split_open(vim.o.cmdwinheight, { type = "vim/search/forward" })
end)
vim.keymap.set("n", "q?", function()
  require("cmdbuf").split_open(vim.o.cmdwinheight, { type = "vim/search/backward" })
end)

-- }}}

-- {{{ obsidian.nvim

-- Search obsidian file
map("n", "<leader>sof", "<cmd>ObsidianQuickSwitch<CR>")

-- Search within obsidian files (ripgrep)
map("n", "<leader>sog", "<cmd>ObsidianSearch<CR>")
-- }}}

-- }}}

-- {{{ Thirdy-party apps (GUI / TUI / CLI ...)

-- TODO: stop using `neovim-remote (nvr)` when nvim --remote becomes reliable
-- SEE: https://github.com/neovim/neovim/commit/e8ee6733926db83ef216497a1d660a173184ff39

-- {{{ Webstorm Ide integration

-- if webstorm cli is present in $PATH, do:
if vim.fn.executable "webstorm" == 1 then
  -- TODO: realtime sync terminal Neovim with Webstorm. Is it possible?
  -- TODO: add and "if project is web related then", how to detect this?

  -- SEE: https://www.reddit.com/r/vim/comments/b2m2dp/move_from_ide_to_vim/
  -- SEE: https://stackoverflow.com/questions/4037984/is-it-possible-to-extend-intellij-such-that-i-can-open-the-current-file-in-vim
  -- SEE: https://vi.stackexchange.com/questions/18073/neovim-qt-is-it-possible-open-files-in-the-existing-window

  -- BUG: if Webstorm isn't already opened, Neovim spawns a new process that blocks
  --      the current Neovim buffer from being edited (cursor won't move), no matter if
  --      using webstorm lightedit mode or not. Is this webstorm cli intended behavior?
  --      Maybe use plenary for launching it asynchronously?
  --      If webstorm was already launched the buffer won't be blocked.
  --        WORKAROUND: This is overcome by using `setsid`, but is a LINUX ONLY solution.
  --        SEE: setsid tip taken from: https://github.com/justinmk/vim-gtfo/issues/50
  --        NOTE: this problem DOESN'T occur on macos.
  local webstorm_launch_cmd

  if is_linux then
    webstorm_launch_cmd = "setsid webstorm"
  elseif is_mac then
    webstorm_launch_cmd = "webstorm"
  end

  -- Open the whole project in Webstorm
  -- and the current file in current cursor position (Webstorm intelligently guesses the project root)
  map(
    "n",
    "goip",
    -- BUG: for some reason webstorm in IdeaVim mode enters in `col('.') + 1`
    -- TODO: report bug upstream
    --      FIX: we manually add the column back inside col('.')
    --           we now have col('.') - 1
    [[<cmd>execute 'silent !]]
      .. webstorm_launch_cmd
      .. [[ --line ' . line('.') . ' --column ' . (col('.') - 1) . ' ' . expand('%:p')<CR>]]
  )

  -- Open only current file in Webstorm (without its project) in current cursor position.
  -- Possible only when using early 2020 releases or later.
  -- This uses the IDE lightedit mode. SEE: https://blog.jetbrains.com/idea/2020/04/lightedit-mode/
  -- `$ westorm -e <file-to-be-light-edited>`
  -- NOTE: for now lightedit mode doesn't support opening files using `--line` and `--column` parameters
  map("n", "goif", [[<cmd>execute 'silent !]] .. webstorm_launch_cmd .. [[ -e ' . expand('%:p')<CR>]])

  -- NOTE: From Webstorm it is possible to go back to terminal Neovim in the same instance and buffer
  -- using IdeaVim plugin and a mapping defined in the $XDG_CONFIG_HOME/ideavim/ideavimrc file (.vimrc analog)
  -- This mapping triggers a custom external tool defined in:
  -- Preferences > Tools > External tools
  -- The tool uses nvr cli (SEE: https://github.com/mhinz/neovim-remote)
  -- SEE: https://www.reddit.com/r/neovim/comments/nehuye/how_to_alternate_between_neovim_and_other_text/
  -- SEE: https://www.reddit.com/r/IntelliJIDEA/comments/dphwrd/how_to_configure_ideavim_shortcut_to_open_file_in/
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
  -- This mapping triggers nvr cli (SEE: https://github.com/mhinz/neovim-remote):
  -- SEE: https://www.reddit.com/r/neovim/comments/nehuye/how_to_alternate_between_neovim_and_other_text/
end

-- }}}

-- {{{ Matlab integration

-- NOTE: not possible
-- SEE: https://www.mathworks.com/matlabcentral/answers/71232-matlab-open-file-in-editor-from-the-command-line

-- }}}

-- }}}

-- TODO: https://www.reddit.com/r/neovim/comments/zy3qq0/til_search_within_visual_selection/

-- TODO: normal mode mapping for <ESC> key
--       SEE: https://www.reddit.com/r/neovim/comments/zmu22y/uses_for_escape_in_normal_mode/

return M
