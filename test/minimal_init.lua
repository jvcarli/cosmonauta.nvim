-- TODO: this could lead to a testing plugin
-- SEE: part is taken from https://github.com/neovim/nvim-lspconfig/blob/master/test/minimal_init.lua

-- Neovim defaults:
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd [[colorscheme default]]

local on_windows = vim.loop.os_uname().version:match "Windows"

local function join_paths(...)
  local path_sep = on_windows and "\\" or "/"
  local result = table.concat({ ... }, path_sep)
  return result
end

-- Adjust runtimepath
vim.cmd [[set runtimepath=~/.config/nvim/test]]
vim.cmd [[set runtimepath+=$VIMRUNTIME]]

local temp_dir = vim.loop.os_getenv "TEMP" or "/tmp"

vim.cmd("set packpath=" .. join_paths(temp_dir, "nvim", "site"))

local package_root = join_paths(temp_dir, "nvim", "site", "pack")
local install_path = join_paths(package_root, "packer", "start", "packer.nvim")
local compile_path = join_paths(install_path, "plugin", "packer_compiled.lua")

-- Define plugins
local test_plugins_status_ok, test_plugins = pcall(dofile, vim.env.HOME .. "/.config/nvim/test/test_plugins.lua")
--
-- NOTE: Packer.nvim will always be needed
if not test_plugins_status_ok then
  -- No plugin list to test yet, but packer will be needed anyway
  test_plugins = { "wbthomason/packer.nvim" }

  print [[WARN: You have not defined a plugin list to test. Please write one, returning it as a lua table at "~/.config/nvim/test/test_plugins.lua".]]
else
  -- append packer to the plugins you want to test so you won't have to include it there
  table.insert(test_plugins, "wbthomason/packer.nvim")
end

local function load_plugins()
  require("packer").startup {
    test_plugins,
    config = {
      package_root = package_root,
      compile_path = compile_path,
    },
  }
end

local load_config = function()
  local config_to_test_status_ok, test_config = pcall(dofile, vim.env.HOME .. "/.config/nvim/test/test_config.lua")

  -- NOTE: Usually configurating something is needed but not always
  if not config_to_test_status_ok then
    print [[WARN: You have not defined a config file to test. If this isn't your intention write one at "~/.config/nvim/test/test_config.lua".]]
  else
    return test_config
  end
end

-- Packer auto install
if vim.fn.isdirectory(install_path) == 0 then
  vim.fn.system { "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }
  load_plugins()
  require("packer").sync()
  local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
  vim.api.nvim_create_autocmd(
    "User",
    { pattern = "PackerComplete", callback = load_config, group = packer_group, once = true }
  )
else
  load_plugins()
  require("packer").sync()
  load_config()
end
