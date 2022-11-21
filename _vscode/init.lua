-- Vscode-neovim init file
-- SEE: https://github.com/vscode-neovim/vscode-neovim
-- Using a init.vim file is possible too:
--   vim.cmd("source " .. vim.fn.stdpath "config" .. "/vscode/init.vim")

-- TODO: It's necessary to include OS specific conditions
--       for macos, Linux and Windows runtimepaths

-- Exclude unnecessary directories from Vscode config.
-- ~/.config/nvim/vscode/lua will be the lua runtime path for vscode instead of the default ~/.config/nvim/lua.
if vim.loop.os_uname().sysname == "Darwin" then
  -- Error caused when using the same runtimepath as Arch Linux:
  --
  --   Error detected while processing /usr/local/Cellar/neovim/HEAD-f3cea06/share/nvim/runtime/syntax/syntax.vim:
  --   line   43:
  --   E216: No such group or event: filetypedetect BufRead
  --   E216: No such group or event: filetypedetect BufRead
  --
  -- Instead
  -- TODO: when installing Neovim using `brew install neovim --HEAD` Homebrew will place
  --       Neovim lib and runtime inside /HEAD-<commithash>/ directory
  --       Use a lua pattern so any commit hash can work

  -- macos custom runtimepath for Vscode configuration
  vim.opt.runtimepath = {
    "~/.config/nvim/_vscode",
    "/usr/local/etc/xdg/nvim",
    "/etc/xdg/nvim",
    "/usr/local/share/nvim/site",
    "/usr/share/nvim/site",
    "/usr/local/Cellar/neovim/HEAD-f3cea06/share/nvim/runtime",
    "/usr/local/Cellar/neovim/HEAD-f3cea06/lib/nvim",
    "/usr/share/nvim/site/after",
    "/usr/local/share/nvim/site/after",
    "/etc/xdg/nvim/after",
    "/usr/local/etc/xdg/nvim/after",
  }
else
  -- Arch Linux
  vim.opt.runtimepath = {
    "~/.config/nvim/_vscode", -- Arch Linux
    "/etc/xdg/nvim", -- Arch Linux
    "/usr/local/share/nvim/site", -- Arch Linux
    "/usr/share/nvim/site", -- Arch Linux
    "/usr/share/nvim/runtime", -- Arch Linux
    "/usr/share/nvim/runtime/pack/dist/opt/matchit", -- Arch Linux
    "/usr/lib/nvim", -- Arch Linux
    "/usr/share/nvim/site/after", -- Arch Linux
    "/usr/local/share/nvim/site/after", -- Arch Linux
    "/etc/xdg/nvim/after", -- Arch Linux
    "/usr/share/vim/vimfiles", -- Arch Linux
  }
  -- TODO: Windows runtimepath for Vscode configuration
end

-- DO NOT use default packpath "~/.local/share/nvim/site/*"
-- because packer.nvim plugin manager uses it and Vscode would load undeseried plugins.
vim.cmd "set packpath="

-- Lua modules
require "keymaps"
