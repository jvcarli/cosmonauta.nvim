" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/Users/development/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/development/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/development/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/development/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/development/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  CmdlineComplete = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/CmdlineComplete"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/barbar.nvim"
  },
  ["defx-git"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/defx-git"
  },
  ["defx-icons"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/defx-icons"
  },
  ["defx.nvim"] = {
    config = { "\27LJ\2\n�\4\0\0\5\0\21\0.6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\3\0=\1\4\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0006\0\0\0009\0\1\0'\1\6\0=\1\a\0006\0\0\0009\0\1\0'\1\3\0=\1\b\0006\0\0\0009\0\t\0009\0\n\0'\2\v\0005\3\f\0B\0\3\0016\0\0\0009\0\t\0009\0\n\0'\2\r\0005\3\14\0B\0\3\0016\0\0\0009\0\t\0009\0\15\0'\2\16\0005\3\17\0B\0\3\0016\0\0\0009\0\t\0009\0\n\0'\2\18\0'\3\19\0005\4\20\0B\0\4\1K\0\1\0\1\0\b\rUnmerged\b═\14Untracked\b◈\fIgnored\b▨\vStaged\b✚\fDeleted\b✖\rModified\b◉\fUnknown\6?\fRenamed\b➜\15indicators\bgit\1\0\1\fcolumns#indent:mark:icons:git:filename\6_\23defx#custom#option\1\0\1\vindent\t    \vindent\1\0\2\18selected_icon\b■\18readonly_icon\b◆\tmark\23defx#custom#column\afn\27defx_icons_parent_icon\30defx_icons_directory_icon\b│'defx_icons_nested_closed_tree_icon'defx_icons_nested_opened_tree_icon\b├%defx_icons_root_opened_tree_icon\6g\bvim\0" },
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/defx.nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/diffview.nvim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  ["git-messenger.vim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/git-messenger.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n�\n\0\0\5\0\26\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\a\0005\4\6\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\3=\3\17\0025\3\18\0005\4\19\0=\4\20\0035\4\21\0=\4\22\3=\3\23\0025\3\24\0=\3\25\2B\0\2\1K\0\1\0\16watch_index\1\0\1\rinterval\3�\a\fkeymaps\tn [c\1\2\1\0@&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'\texpr\2\tn ]c\1\2\1\0@&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'\texpr\2\1\0\n\17n <leader>hb4<cmd>lua require\"gitsigns\".blame_line(true)<CR>\to ih2:<C-U>lua require\"gitsigns\".select_hunk()<CR>\fnoremap\2\tx ih2:<C-U>lua require\"gitsigns\".select_hunk()<CR>\17n <leader>hp2<cmd>lua require\"gitsigns\".preview_hunk()<CR>\17n <leader>hR2<cmd>lua require\"gitsigns\".reset_buffer()<CR>\17n <leader>hr0<cmd>lua require\"gitsigns\".reset_hunk()<CR>\17n <leader>hu5<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>\vbuffer\2\17n <leader>hs0<cmd>lua require\"gitsigns\".stage_hunk()<CR>\nsigns\17changedelete\1\0\4\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\ttext\6-\14topdelete\1\0\4\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\ttext\b‾\vdelete\1\0\4\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\ttext\6_\vchange\1\0\4\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\ttext\6~\badd\1\0\0\1\0\4\ahl\16GitSignsAdd\nnumhl\18GitSignsAddNr\vlinehl\18GitSignsAddLn\ttext\6+\tyadm\1\0\a\vlinehl\1\nnumhl\1\22use_internal_diff\2\23use_decoration_api\2\20update_debounce\3d\18sign_priority\3\6\23current_line_blame\1\1\0\1\venable\2\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/goyo.vim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n�\4\0\0\2\0\15\0!6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0006\0\0\0009\0\1\0005\1\a\0=\1\6\0006\0\0\0009\0\1\0'\1\t\0=\1\b\0006\0\0\0009\0\1\0+\1\2\0=\1\n\0006\0\0\0009\0\1\0+\1\2\0=\1\v\0006\0\0\0009\0\1\0+\1\2\0=\1\f\0006\0\0\0009\0\1\0005\1\14\0=\1\r\0K\0\1\0\1\15\0\0\nclass\rfunction\vmethod\b^if\nwhile\bfor\twith\17func_literal\nblock\btry\vexcept\18argument_list\vobject\15dictionary&indent_blankline_context_patterns*indent_blankline_show_current_context\27indent_blankline_debug!indent_blankline_strict_tabs\6 *indent_blankline_space_char_blankline\1\2\0\0\rterminal%indent_blankline_buftype_exclude\1\a\0\0\thelp\tdefx\fvimwiki\bman\22gitmessengerpopup\20diagnosticpopup&indent_blankline_filetype_exclude\b│\26indent_blankline_char\6g\bvim\0" },
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lexima.vim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/lexima.vim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n`\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\ntheme\15tokyonight\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\2\n�\4\0\0\6\0\22\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0005\5\18\0=\5\19\4=\4\20\3=\3\21\2B\0\2\1K\0\1\0\vsource\nemoji\14filetypes\1\3\0\0\rmarkdown\ttext\1\0\1\tkind\18 ﲃ  (Emoji)\nspell\1\0\1\tkind\18   (Spell)\rnvim_lsp\1\0\1\tkind\16   (LSP)\nvsnip\1\0\1\tkind\20   (Snippet)\tcalc\1\0\1\tkind\17   (Calc)\vbuffer\1\0\1\tkind\19   (Buffer)\tpath\1\0\3\26vim_dadbod_completion\2\ttags\1\rnvim_lua\2\1\0\1\tkind\17   (Path)\1\0\f\18throttle_time\3P\19source_timeout\3�\1\14preselect\venable\15min_length\3\1\17autocomplete\2\fenabled\2\18documentation\2\19max_menu_width\3d\19max_kind_width\3d\19max_abbr_width\3d\21incomplete_delay\3�\3\ndebug\1\nsetup\ncompe\frequire\0" },
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-dap-python"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/nvim-dap-python"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n�\1\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\1K\0\1\0\26context_commentstring\1\0\1\venable\2\fautotag\1\0\1\venable\2\14highlight\1\0\2\18language_tree\2\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["octo.nvim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/octo.nvim"
  },
  ["open-browser.vim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/open-browser.vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["quick-scope"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/quick-scope"
  },
  sniprun = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\18initial_setup\fsniprun\frequire\0" },
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/sniprun"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/splitjoin.vim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n�\6\0\0\6\0&\0-6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\a\0005\4\4\0005\5\5\0=\5\6\4=\4\b\0035\4\t\0005\5\n\0=\5\6\4=\4\v\0035\4\f\0=\4\r\0035\4\14\0005\5\15\0=\5\6\4=\4\16\0035\4\17\0005\5\18\0=\5\6\4=\4\19\0035\4\20\0005\5\21\0=\5\6\4=\4\22\3=\3\23\0025\3\24\0=\3\25\0025\3\27\0005\4\26\0=\4\28\0035\4\29\0=\4\30\0035\4\31\0=\4 \0035\4!\0=\4\"\0035\4#\0=\4$\3=\3%\2B\0\2\1K\0\1\0\vcolors\fdefault\1\3\0\0\15Identifier\f#7C3AED\thint\1\3\0\0\30LspDiagnosticsDefaultHint\f#10B981\tinfo\1\3\0\0%LspDiagnosticsDefaultInformation\f#2563EB\fwarning\1\4\0\0!LspDiagnosticsDefaultWarning\15WarningMsg\f#FBBF24\nerror\1\0\0\1\4\0\0\31LspDiagnosticsDefaultError\rErrorMsg\f#DC2626\14highlight\1\0\3\vbefore\5\nafter\afg\fkeyword\twide\rkeywords\tNOTE\1\5\0\0\tINFO\bSee\bsee\bSEE\1\0\2\ncolor\thint\ticon\t \tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\1\ticon\t \tWARN\1\3\0\0\fWARNING\bXXX\1\0\2\ncolor\fwarning\ticon\t \tHACK\1\0\2\ncolor\fwarning\ticon\t \tTODO\1\3\0\0\nTO DO\tTODO\1\0\2\ncolor\tinfo\ticon\t \bFIX\1\0\0\balt\1\6\0\0\nFIXME\bBUG\nFIXIT\bFIX\nISSUE\1\0\2\ncolor\nerror\ticon\t \1\0\1\nsigns\2\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/todo-comments.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n�\3\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\3=\3\r\0025\3\14\0=\3\15\2B\0\2\1K\0\1\0\nsigns\1\0\4\fwarning\b\16information\b\thint\b\nerror\b\16action_keys\16toggle_fold\1\3\0\0\azA\aza\15open_folds\1\3\0\0\azR\azr\16close_folds\1\3\0\0\azM\azm\tjump\1\3\0\0\t<cr>\n<tab>\1\0\b\19toggle_preview\6P\16toggle_mode\6m\fpreview\6p\tnext\6j\vcancel\n<esc>\nclose\6q\rprevious\6k\frefresh\6r\1\0\v\14auto_open\1\tmode\rdocument\14fold_open\b\17auto_preview\2\nicons\2\vheight\3\b\17indent_lines\2\15auto_close\2\14auto_fold\2\29use_lsp_diagnostic_signs\1\16fold_closed\b\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  undotree = {
    config = { "\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\2\0=\1\2\0K\0\1\0\26undotree_WindowLayout\6g\bvim\0" },
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-hexokinase"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/vim-hexokinase"
  },
  ["vim-indent-object"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/vim-indent-object"
  },
  ["vim-lineletters"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/vim-lineletters"
  },
  ["vim-signature"] = {
    config = { "\27LJ\2\n<\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\31SignatureMarkTextHLDynamic\6g\bvim\0" },
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/vim-signature"
  },
  ["vim-sneak"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/vim-sneak"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/vim-visual-multi"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  vimtex = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/vimtex"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/vista.vim"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/Users/development/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time("Defining packer_plugins", false)
-- Config for: todo-comments.nvim
time("Config for todo-comments.nvim", true)
try_loadstring("\27LJ\2\n�\6\0\0\6\0&\0-6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\a\0005\4\4\0005\5\5\0=\5\6\4=\4\b\0035\4\t\0005\5\n\0=\5\6\4=\4\v\0035\4\f\0=\4\r\0035\4\14\0005\5\15\0=\5\6\4=\4\16\0035\4\17\0005\5\18\0=\5\6\4=\4\19\0035\4\20\0005\5\21\0=\5\6\4=\4\22\3=\3\23\0025\3\24\0=\3\25\0025\3\27\0005\4\26\0=\4\28\0035\4\29\0=\4\30\0035\4\31\0=\4 \0035\4!\0=\4\"\0035\4#\0=\4$\3=\3%\2B\0\2\1K\0\1\0\vcolors\fdefault\1\3\0\0\15Identifier\f#7C3AED\thint\1\3\0\0\30LspDiagnosticsDefaultHint\f#10B981\tinfo\1\3\0\0%LspDiagnosticsDefaultInformation\f#2563EB\fwarning\1\4\0\0!LspDiagnosticsDefaultWarning\15WarningMsg\f#FBBF24\nerror\1\0\0\1\4\0\0\31LspDiagnosticsDefaultError\rErrorMsg\f#DC2626\14highlight\1\0\3\vbefore\5\nafter\afg\fkeyword\twide\rkeywords\tNOTE\1\5\0\0\tINFO\bSee\bsee\bSEE\1\0\2\ncolor\thint\ticon\t \tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\1\ticon\t \tWARN\1\3\0\0\fWARNING\bXXX\1\0\2\ncolor\fwarning\ticon\t \tHACK\1\0\2\ncolor\fwarning\ticon\t \tTODO\1\3\0\0\nTO DO\tTODO\1\0\2\ncolor\tinfo\ticon\t \bFIX\1\0\0\balt\1\6\0\0\nFIXME\bBUG\nFIXIT\bFIX\nISSUE\1\0\2\ncolor\nerror\ticon\t \1\0\1\nsigns\2\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time("Config for todo-comments.nvim", false)
-- Config for: defx.nvim
time("Config for defx.nvim", true)
try_loadstring("\27LJ\2\n�\4\0\0\5\0\21\0.6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\3\0=\1\4\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0006\0\0\0009\0\1\0'\1\6\0=\1\a\0006\0\0\0009\0\1\0'\1\3\0=\1\b\0006\0\0\0009\0\t\0009\0\n\0'\2\v\0005\3\f\0B\0\3\0016\0\0\0009\0\t\0009\0\n\0'\2\r\0005\3\14\0B\0\3\0016\0\0\0009\0\t\0009\0\15\0'\2\16\0005\3\17\0B\0\3\0016\0\0\0009\0\t\0009\0\n\0'\2\18\0'\3\19\0005\4\20\0B\0\4\1K\0\1\0\1\0\b\rUnmerged\b═\14Untracked\b◈\fIgnored\b▨\vStaged\b✚\fDeleted\b✖\rModified\b◉\fUnknown\6?\fRenamed\b➜\15indicators\bgit\1\0\1\fcolumns#indent:mark:icons:git:filename\6_\23defx#custom#option\1\0\1\vindent\t    \vindent\1\0\2\18selected_icon\b■\18readonly_icon\b◆\tmark\23defx#custom#column\afn\27defx_icons_parent_icon\30defx_icons_directory_icon\b│'defx_icons_nested_closed_tree_icon'defx_icons_nested_opened_tree_icon\b├%defx_icons_root_opened_tree_icon\6g\bvim\0", "config", "defx.nvim")
time("Config for defx.nvim", false)
-- Config for: which-key.nvim
time("Config for which-key.nvim", true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time("Config for which-key.nvim", false)
-- Config for: gitsigns.nvim
time("Config for gitsigns.nvim", true)
try_loadstring("\27LJ\2\n�\n\0\0\5\0\26\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\a\0005\4\6\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\3=\3\17\0025\3\18\0005\4\19\0=\4\20\0035\4\21\0=\4\22\3=\3\23\0025\3\24\0=\3\25\2B\0\2\1K\0\1\0\16watch_index\1\0\1\rinterval\3�\a\fkeymaps\tn [c\1\2\1\0@&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'\texpr\2\tn ]c\1\2\1\0@&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'\texpr\2\1\0\n\17n <leader>hb4<cmd>lua require\"gitsigns\".blame_line(true)<CR>\to ih2:<C-U>lua require\"gitsigns\".select_hunk()<CR>\fnoremap\2\tx ih2:<C-U>lua require\"gitsigns\".select_hunk()<CR>\17n <leader>hp2<cmd>lua require\"gitsigns\".preview_hunk()<CR>\17n <leader>hR2<cmd>lua require\"gitsigns\".reset_buffer()<CR>\17n <leader>hr0<cmd>lua require\"gitsigns\".reset_hunk()<CR>\17n <leader>hu5<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>\vbuffer\2\17n <leader>hs0<cmd>lua require\"gitsigns\".stage_hunk()<CR>\nsigns\17changedelete\1\0\4\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\ttext\6-\14topdelete\1\0\4\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\ttext\b‾\vdelete\1\0\4\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\ttext\6_\vchange\1\0\4\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\ttext\6~\badd\1\0\0\1\0\4\ahl\16GitSignsAdd\nnumhl\18GitSignsAddNr\vlinehl\18GitSignsAddLn\ttext\6+\tyadm\1\0\a\vlinehl\1\nnumhl\1\22use_internal_diff\2\23use_decoration_api\2\20update_debounce\3d\18sign_priority\3\6\23current_line_blame\1\1\0\1\venable\2\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time("Config for gitsigns.nvim", false)
-- Config for: nvim-compe
time("Config for nvim-compe", true)
try_loadstring("\27LJ\2\n�\4\0\0\6\0\22\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0005\5\18\0=\5\19\4=\4\20\3=\3\21\2B\0\2\1K\0\1\0\vsource\nemoji\14filetypes\1\3\0\0\rmarkdown\ttext\1\0\1\tkind\18 ﲃ  (Emoji)\nspell\1\0\1\tkind\18   (Spell)\rnvim_lsp\1\0\1\tkind\16   (LSP)\nvsnip\1\0\1\tkind\20   (Snippet)\tcalc\1\0\1\tkind\17   (Calc)\vbuffer\1\0\1\tkind\19   (Buffer)\tpath\1\0\3\26vim_dadbod_completion\2\ttags\1\rnvim_lua\2\1\0\1\tkind\17   (Path)\1\0\f\18throttle_time\3P\19source_timeout\3�\1\14preselect\venable\15min_length\3\1\17autocomplete\2\fenabled\2\18documentation\2\19max_menu_width\3d\19max_kind_width\3d\19max_abbr_width\3d\21incomplete_delay\3�\3\ndebug\1\nsetup\ncompe\frequire\0", "config", "nvim-compe")
time("Config for nvim-compe", false)
-- Config for: vim-signature
time("Config for vim-signature", true)
try_loadstring("\27LJ\2\n<\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\31SignatureMarkTextHLDynamic\6g\bvim\0", "config", "vim-signature")
time("Config for vim-signature", false)
-- Config for: nvim-treesitter
time("Config for nvim-treesitter", true)
try_loadstring("\27LJ\2\n�\1\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\1K\0\1\0\26context_commentstring\1\0\1\venable\2\fautotag\1\0\1\venable\2\14highlight\1\0\2\18language_tree\2\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time("Config for nvim-treesitter", false)
-- Config for: sniprun
time("Config for sniprun", true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\18initial_setup\fsniprun\frequire\0", "config", "sniprun")
time("Config for sniprun", false)
-- Config for: undotree
time("Config for undotree", true)
try_loadstring("\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\2\0=\1\2\0K\0\1\0\26undotree_WindowLayout\6g\bvim\0", "config", "undotree")
time("Config for undotree", false)
-- Config for: indent-blankline.nvim
time("Config for indent-blankline.nvim", true)
try_loadstring("\27LJ\2\n�\4\0\0\2\0\15\0!6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0006\0\0\0009\0\1\0005\1\a\0=\1\6\0006\0\0\0009\0\1\0'\1\t\0=\1\b\0006\0\0\0009\0\1\0+\1\2\0=\1\n\0006\0\0\0009\0\1\0+\1\2\0=\1\v\0006\0\0\0009\0\1\0+\1\2\0=\1\f\0006\0\0\0009\0\1\0005\1\14\0=\1\r\0K\0\1\0\1\15\0\0\nclass\rfunction\vmethod\b^if\nwhile\bfor\twith\17func_literal\nblock\btry\vexcept\18argument_list\vobject\15dictionary&indent_blankline_context_patterns*indent_blankline_show_current_context\27indent_blankline_debug!indent_blankline_strict_tabs\6 *indent_blankline_space_char_blankline\1\2\0\0\rterminal%indent_blankline_buftype_exclude\1\a\0\0\thelp\tdefx\fvimwiki\bman\22gitmessengerpopup\20diagnosticpopup&indent_blankline_filetype_exclude\b│\26indent_blankline_char\6g\bvim\0", "config", "indent-blankline.nvim")
time("Config for indent-blankline.nvim", false)
-- Config for: lualine.nvim
time("Config for lualine.nvim", true)
try_loadstring("\27LJ\2\n`\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\ntheme\15tokyonight\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time("Config for lualine.nvim", false)
-- Config for: trouble.nvim
time("Config for trouble.nvim", true)
try_loadstring("\27LJ\2\n�\3\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\3=\3\r\0025\3\14\0=\3\15\2B\0\2\1K\0\1\0\nsigns\1\0\4\fwarning\b\16information\b\thint\b\nerror\b\16action_keys\16toggle_fold\1\3\0\0\azA\aza\15open_folds\1\3\0\0\azR\azr\16close_folds\1\3\0\0\azM\azm\tjump\1\3\0\0\t<cr>\n<tab>\1\0\b\19toggle_preview\6P\16toggle_mode\6m\fpreview\6p\tnext\6j\vcancel\n<esc>\nclose\6q\rprevious\6k\frefresh\6r\1\0\v\14auto_open\1\tmode\rdocument\14fold_open\b\17auto_preview\2\nicons\2\vheight\3\b\17indent_lines\2\15auto_close\2\14auto_fold\2\29use_lsp_diagnostic_signs\1\16fold_closed\b\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time("Config for trouble.nvim", false)
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
