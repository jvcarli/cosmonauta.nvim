local M = {}

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

return M
