local M = {}

local file_exists = require("user.modules.utils").file_exists
local Job = require "plenary.job"

-- I'm pretty sure this is poorly written
M.provider_exists = function(provider_path)
  if file_exists(provider_path) then
    return true
  else
    return false
  end
end

-- checks if python provider exists if it doesn't installs it
M.install_python_provider = function(python3_venv_path, python3_provider_path)
  -- Arch Linux: uses system python to install
  -- macos: uses native macos python3

  local python3_command

  if vim.loop.os_uname().sysname == "Darwin" then
    -- Use native macos python3
    python3_command = "/usr/bin/python3"
  end

  -- working with Plenary jobs: https://www.reddit.com/r/neovim/comments/pa4yle/help_with_async_in_lua/
  Job
    :new({
      command = python3_command,
      args = { "-m", "venv", python3_venv_path },
      on_exit = function(_, venv_creation_return_val)
        if venv_creation_return_val == 0 then
          print "python3 venv was setup for Neovim usage!"
          Job
            :new({
              command = python3_provider_path,
              args = { "-m", "pip", "install", "pynvim" },
              on_exit = function(_, pynvim_return_val)
                if pynvim_return_val == 0 then
                  -- NOTE: Neovim MUST be restarted to apply changes
                  print "pynvim python package was successful installed inside python3 Neovim venv! Restart Neovim to apply changes!"
                else
                  print "Something wrong happened! Pynvim python package could not be installed inside Neovim python3 venv"
                end
              end,
            })
            :start()
        else
          print "Something wrong happened! A python3 venv for Neovim usage could not be created!"
        end
      end,
    })
    :start()
end

return M
