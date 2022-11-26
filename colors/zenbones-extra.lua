local zenbones_status_ok = pcall(require, "zenbones")
if not zenbones_status_ok then
  -- zenbones.nvim is not installed
  return
else
  -- Setup zenbones extra highlight groups
  -- TODO: use lush.nvim to extend this colorscheme?

  -- Setup default zenbones theme
  vim.cmd "set background=light"
  vim.cmd "runtime colors/zenbones.vim"

  -- marks.nvim
  -- no color in marked line signcolumn number
  vim.cmd "highlight MarkSignHL gui=bold"
  vim.cmd "highlight MarkSignNumHL guibg=none guifg=none"

  -- rhysd/clever-f.vim
  vim.cmd "highlight CleverFDefaultLabel cterm=bold ctermfg=9 gui=bold guifg=#A8334C"

  -- folke/todo-comments.nvim
  vim.cmd "highlight TodoFgNOTE gui=bold guifg=#88507d"
  vim.cmd "highlight TodoFgFIX  gui=bold guifg=#a8334c"
  vim.cmd "highlight TodoFgWARN gui=bold guifg=#944927"
  vim.cmd "highlight TodoFgPERF gui=bold guifg=#44525b"
  vim.cmd "highlight TodoFgHACK gui=bold guifg=#944927"
  vim.cmd "highlight TodoFgTODO gui=bold guifg=#286486"

  -- vim match-up
  -- MatchParen is a default highlight group from Neovim
  -- MatchParenCur (for current parenthesis) and MatchWord are hi groups from matchup
  vim.cmd "highlight MatchWord           guifg=#d79921 guibg=none" -- if, else, function, etc.
  vim.cmd "highlight MatchParen gui=bold guifg=#d79921 guibg=none" -- Paren, brackets
  vim.cmd "highlight link MatchParenCur MatchParen"

  -- vim-illuminate
  -- Highlighting is done using the same highlight groups as the builtin LSP
  -- which is LspReferenceText, LspReferenceRead, and LspReferenceWrite.
  -- I'm overwriting LspReference* groups, which was linked to CursorLine group
  vim.cmd [[ hi IlluminatedWordText  cterm=underline guibg=#f3dcb0 ]]
  vim.cmd [[ hi IlluminatedWordWrite cterm=underline guibg=#f3dcb0 ]]
  vim.cmd [[ hi IlluminatedWordRead  cterm=underline guibg=#f3dcb0 ]]

  -- vim-dirvish
  -- SEE: https://github.com/justinmk/vim-dirvish/issues/208
  vim.cmd "highlight DirvishPathTail gui=bold guifg=#286486"
  vim.cmd "highlight DirvishArg gui=boldunderline guibg=#d79921"

  -- Diffview.nvim
  -- TODO: check colors
  vim.cmd "highlight link DiffviewDiffDelete Comment"
  vim.cmd "highlight link DiffviewFolderSign PreProc"
  vim.cmd "highlight link DiffviewFolderName Directory"
  vim.cmd "highlight link DiffviewEndOfBuffer EndOfBuffer"
  vim.cmd "highlight link DiffviewFilePanelDeletions diffRemoved"
  vim.cmd "highlight link DiffviewStatusTypeChange diffChanged"
  vim.cmd "highlight link DiffviewFilePanelInsertions diffAdded"

  vim.cmd "highlight diffRemoved guifg=#A8334C" -- ok
  vim.cmd "highlight diffChanged guifg=#286486" -- ok
  vim.cmd "highlight diffAdded guifg=#4F6C31" -- ok

  vim.cmd "highlight DiffviewPrimary guifg=#286496" -- ok
  vim.cmd "highlight DiffviewSecondary gui=bold guifg=#d79921" -- ok
  vim.cmd "highlight DiffviewDiffAddAsDelete gui=bold guifg=red guibg=DarkCyan"
  vim.cmd "highlight DiffviewDim1 guibg=Cyan"
  vim.cmd "highlight DiffviewFilePanelFileName guifg=#2C363C"
  vim.cmd "highlight DiffviewFilePanelCounter gui=bold guifg=#d79921" -- ok
  vim.cmd "highlight DiffviewFilePanelTitle gui=bold guifg=#286486"

  vim.cmd "highlight link DiffviewFilePanelPath Comment"
  vim.cmd "highlight link DiffviewFilePanelRootPath DiffviewFilePanelTitle"
  vim.cmd "highlight link DiffviewStatusLineNC StatusLineNC"
  vim.cmd "highlight link DiffviewStatusLine StatusLine"
  vim.cmd "highlight link DiffviewVertSplit VertSplit"
  vim.cmd "highlight link DiffviewCursorLine CursorLine"
  vim.cmd "highlight link DiffviewNonText NonText"
  vim.cmd "highlight link DiffviewStatusIgnored Comment"
  vim.cmd "highlight link DiffviewStatusBroken diffRemoved"
  vim.cmd "highlight link DiffviewStatusDeleted diffRemoved"
  vim.cmd "highlight link DiffviewStatusUnknown diffRemoved"
  vim.cmd "highlight link DiffviewStatusUnmerged diffChanged"
  vim.cmd "highlight link DiffviewStatusCopied diffChanged"
  vim.cmd "highlight link DiffviewStatusRenamed diffChanged"
  vim.cmd "highlight link DiffviewStatusModified diffChanged"
  vim.cmd "highlight link DiffviewSignColumn Normal"
  vim.cmd "highlight link DiffviewStatusUntracked diffAdded"
  vim.cmd "highlight link DiffviewNormal Normal"
  vim.cmd "highlight link DiffviewStatusAdded diffAdded"

  -- Remove tildes from blank lines
  -- For some reason this has to be in the bottom off the config file
  -- taken from: https://stackoverflow.com/questions/3813059/is-it-possible-to-not-display-a-for-blank-lines-in-vim-neovim
  -- is problematic when "eol" and "space" list_chars are used because it omits them.
  -- vim.cmd "hi NonText guifg=bg"

  -- indent-blankline.nvim
  vim.cmd [[highlight IndentBlanklineContextChar gui=nocombine guifg=#88507d]]

  -- mini.nvim trailspace module
  -- replaces vim-better-whitespace
  vim.cmd [[highlight MiniTrailspace guibg=#A8334C]]
end
