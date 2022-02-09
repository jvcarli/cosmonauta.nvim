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
  -- plugin = {}

  return packer_plugins[plugin] and packer_plugins[plugin].loaded
end

return M
