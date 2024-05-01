local map = vim.keymap.set

-- Leader key
-- Remap space as leader key
-- taken from defaults.nvim: https://github.com/mjlbach/defaults.nvim/blob/master/init.lua

-- <space> is leader and "\" char (default leader) works independetly
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "gon", function()
  -- BUG: Current file name in % register is invalid #798
  --   e.g.: It outputs
  --     /home/user/.dotfiles/nvim/.config/nvim/__vscode_neovim__-file:///home/user/project/filename.ext
  --   instead of:
  --     /home/user/project/filename.ext
  --
  --   SEE: https://github.com/vscode-neovim/vscode-neovim/issues/798
  --   SEE: https://github.com/vscode-neovim/vscode-neovim#-how-it-works
  local wrong_vim_path_expand = vim.fn.expand "%:p"

  -- We MUST clean the path to behave like the correct `"%:p"` expand
  -- taken from: https://stackoverflow.com/questions/53825501/how-to-remove-all-characters-before-last-matching-character-in-lua
  -- TODO: is it possible to hijack the `%` operator so it always behave like it should?
  local cleaned_current_filepath = wrong_vim_path_expand:gsub(".*-file://", "")

  -- Resolve the path to the its absolute form
  local resolved_current_filepath = vim.fn.resolve(cleaned_current_filepath)

  -- WARN: for debugging remove silent from the command below!
  -- TODO: find a way to focus terminal Neovim automatically when invoking remote commands

  -- Solution using neovim-remote
  -- SEE: https://github.com/mhinz/neovim-remote
  -- Invokes nvr and attaches to the current terminal Neovim session and window
  -- NOTE: it uses $NVIM_LISTEN_ADDRESS as servername which by default is set to
  --       `/tmp/nvr/nvimsocket` when outside tmux and
  --       `/tmp/tmux-nvr/<socket-id>` when in TMUX
  --       This makes sure that vscode will invoke the terminal neovim session
  --       that I'm currently using.
  vim.cmd(
    [[execute 'silent !nvr --nostart --servername ]]
      -- WARN: MUST be the same $NVIM_LISTEN_ADDRESS that is currently being used in the terminal session
      --       but the problem is: vim.v.servername correctly outputs it $NVIM_LISTEN_ADDRESS when inside the terminal
      --       but the vscode instance don't because it uses another socket for $NVIM_LISTEN_ADDRESS, a.k.a vim.v.servername
      --       defaulting to /tmp/nvr/nvimsocket for now
      .. "/tmp/nvr/nvimsocket"
      .. [[ "+call cursor(]]
      .. vim.fn.line "."
      .. [[,]]
      .. vim.fn.col "."
      .. [[)" ]]
      .. resolved_current_filepath
      .. [[']]
  )

  -- TODO: ditch nvr in favor of nvim remote
  --       SEE: https://www.reddit.com/r/neovim/comments/tva95r/new_feature_nvim_remote/
  --       SEE: :h remote
  --       NOTE: native remote feature is still incomplete, so it's better using neovim-remote (nvr) fow now
end)
