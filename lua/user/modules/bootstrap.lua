local M = {}
local is_mac = require("user.modules.utils").is_mac
local is_linux = require("user.modules.utils").is_linux

M.base_pkg = {
  "fd",
  "git",
  "rg",
  "shfmt",
  "selene",
  "texlab",
  "xdotool", -- vimtex.vim plugin, TODO: is xdotool really needed? I don't think it is.
  "pylsp", -- python-lsp-server pkg (pylsp (community fork) NOT pyls_ms (microsoft)). TODO: Make it work just like python-llsp-server[all]
  -- "jedi-language-server",
}

M.linux_pkg = function()
  -- Arch Linux easy detection
  if vim.fn.executable "pacman" == 1 then
    return {
      "xsel", -- required for paste.vim plugin. TODO: verify if is it required for linux clipboard too?
    }
  end
end

-- TODO: include required Latex packages for Linux (Arch)
-- on Linux installed required Latex package with:

M.macos_pkg = {
  "selene",
  "dict", -- verify
}

M.macos_casks_pkg = {
  "mactex-no-gui", -- required Latex packages
}

M.is_executable = function(base_pkg)
  for _, value in pairs(base_pkg) do
    if vim.fn.executable(value) ~= 1 then
      vim.notify(value .. [[ executable wasn't found or is not in the $PATH!]])
    end
  end
end

M.append_to_table = function(to, from)
  for _, value in pairs(from) do
    table.insert(to, value)
  end
end

-- TODO: Add complete bootstrap
--       It should resolve itself, no matter if OS is a Linux distro, macos or Windows.
M.bootstrap_run = function()
  if is_mac then
    M.append_to_table(M.base_pkg, M.macos_pkg) -- include macos only pkgs in default pkgs
    M.is_executable(M.base_pkg)
    return
  elseif is_linux then
    local linux_pkg = M.linux_pkg()
    if linux_pkg ~= nil then
      M.append_to_table(M.base_pkg, linux_pkg) -- include linux only pkgs in default pkgs
      M.is_executable(M.base_pkg)
      return
    end
    vim.notify "You will need to manually install the required packages for your distro!"
    return
  end
  -- TODO: write Windows bootstrapping logic
end

return M.bootstrap_run()
