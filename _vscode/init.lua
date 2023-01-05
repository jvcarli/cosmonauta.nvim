-- Vscode-neovim init file
-- SEE: https://github.com/vscode-neovim/vscode-neovim
-- Using a init.vim file is possible too:
--   vim.cmd("source " .. vim.fn.stdpath "config" .. "/vscode/init.vim")

-- Exclude unnecessary directories from Vscode config.
-- ~/.config/nvim/vscode/lua will be the lua runtime path for vscode instead of the default ~/.config/nvim/lua.

local VIMRUNTIME = vim.env.VIMRUNTIME

if vim.loop.os_uname().sysname == "Darwin" then
  -- macos custom runtimepath for Vscode configuration
  -- NOTE: it seems that on macos the only default runtimepath that actually exists
  --       is /usr/local/Cellar/neovim/HEAD-<commithash>/share/nvim/runtime for dev installs
  --       or TODO: include default path when brew install neovim is used instead of brew install neovim --HEAD

  vim.opt.runtimepath = {

    "~/.config/nvim/_vscode",
    VIMRUNTIME,

    "~/.local/share/vscode-neovim/site/pack/*/start/*",
  }
else
  -- TODO: clean paths for Arch Linux, see which paths are actually used.
  -- Arch Linux:
  vim.opt.runtimepath = {
    "~/.config/nvim/_vscode",
    "/etc/xdg/nvim",
    "/usr/local/share/nvim/site",
    "/usr/share/nvim/site",
    "/usr/share/nvim/runtime",
    "/usr/share/nvim/runtime/pack/dist/opt/matchit",
    "/usr/lib/nvim",
    "/usr/share/nvim/site/after",
    "/usr/local/share/nvim/site/after",
    "/etc/xdg/nvim/after",
    "/usr/share/vim/vimfiles",
  }
  -- TODO: set Windows runtimepath for Vscode configuration
end

-- DO NOT use default packpath "~/.local/share/nvim/site/*"
-- because some plugin managers use this path and Vscode would load undesired plugins.
vim.opt.packpath = { "~/.local/share/vscode-neovim/site" }

-- Plugins and its settings.
require "plugins"

-- Lua modules
require "keymaps"
