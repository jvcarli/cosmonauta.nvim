local M = {}

-- TODO: don't depend on lspconfig
local lspconfig_util = require "lspconfig.util"

M.executable = function(cmdline_tool)
  if vim.fn.executable(cmdline_tool) == 1 then
    return true
  else
    -- TODO: make a bootstrap helper that installs the necessary cmdline tools and remove the print below
    print("Install " .. cmdline_tool .. " cmdline tool or run the bootstrap helper!")
  end
end

M.installed_and_loaded = function(plugin)
  if M.file_exists(vim.fn.getenv "HOME" .. "/.config/nvim/lua/packer/packer_compiled.lua") then
    return packer_plugins[plugin] and packer_plugins[plugin].loaded
  else
    return false
  end
end

M.file_exists = function(...)
  -- SEE: https://stackoverflow.com/questions/7573588/variable-number-of-function-arguments-lua-5-1
  local files_to_check = { ... }
  for _, file in pairs(files_to_check) do
    -- TODO: include tilde expansion
    -- SEE: https://stackoverflow.com/questions/3098521/how-to-detect-if-a-specific-file-exists-in-vimscript
    if vim.fn.filereadable(file) ~= 1 then
      return nil -- is returning nil the same as just `return`?
    end
  end
  return true
end

--- Function equivalent to basename in POSIX systems
--- taken from: https://github.com/Donearm/scripts/blob/master/lib/basename.lua
--@param str the path string
M.basename = function(str)
  local name = string.gsub(str, "(.*/)(.*)", "%2")
  return name
end

-- TODO: wrap all of of os detection functions into one is_os(osname) function
M.is_mac = vim.fn.has "macunix" == 1
--
M.is_wsl = (function()
  local output = vim.fn.systemlist "uname -r"
  return not not string.find(output[1] or "", "WSL")
end)()
--
M.is_linux = not M.is_wsl and not M.is_mac

-- Send desktop notifications using Kitty
-- It works even if being used via ssh
-- NOTE: It doesn't really on osascript, so it is safer (?)
-- SEE: https://sw.kovidgoyal.net/kitty/desktop-notifications/#desktop-notifications
-- SEE: https://github.com/simrat39/desktop-notify.nvim/issues/2
M.kitty_send_desktop_notification = function(title, body)
  local notification_body
  if not vim.env.TMUX and vim.env.TERM == "xterm-kitty" then
    if title == nil then
      -- means we are sending a simple, single line notification
      notification_body = vim.api.nvim_chan_send(vim.v.stderr, "\027]99;;" .. body .. "\027\\")
      return notification_body
    else
      vim.api.nvim_chan_send(vim.v.stderr, "\027]99;i=1:d=0;" .. title .. "\027\\")
      notification_body = vim.api.nvim_chan_send(vim.v.stderr, "\027]99;i=1:d=1:p=body;" .. body .. "\027\\")
      return notification_body
    end
  end
end

M.bare_git_root_dir = function(startpath)
  -- NOTE: works but I think the logic here is a little sketchy.

  -- Try to find project_root and return the project root string if found.
  --
  -- Try first to see if there's the project root is based on git worktrees workflow,
  -- i.e. is based on git bare repos.
  -- If not then search for regular git repos.
  -- NOTE: this assume a certain workflow.
  -- TODO: include notes on what workflow this assumes.
  local project_root = lspconfig_util.root_pattern "worktrees"(startpath) --[[ or lspconfig_util.root_pattern ".git"(startpath) ]]

  -- Means that we are starting Neovim from literraly inside of .git/* directory of a bare repo:
  -- This assumes that that .git/* is ONE LEVEL DEPTH into the main project directory.
  -- Start neovim from .git/*  will be rare,
  -- but when one want to internals of the git directory or edit local git config files will be usefull.
  if project_root ~= nil then
    if M.basename(project_root) == ".git" then
      -- Remove pattern ".git" from then end of the string
      -- meaning we are returning main directory of the projct, i.e. the real project root
      return project_root:gsub("/.git", "")
    end
  end

  return project_root
end
return M
