-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

local function detect_system()
  local system_name
  if vim.fn.has "mac" == 1 then
    system_name = "macOS"
  elseif vim.fn.has "unix" == 1 then
    system_name = "Linux"
  elseif vim.fn.has "win32" == 1 then
    system_name = "Windows"
  else
    print "Unsupported system for this configuration"
  end
end

local function detect_dependencies()
  --=======================================--
  --     Packer plugins dependencies       --
  --=======================================--

  -- required cli for packer
  local packer_required = { "git" }
end

-- Init bootstrap
function Bootstrap_nvim()
  local system
  system = detect_system()
  if system == "linux" then
    print "oi"
  end
end

-- Language servers that will be installed by macos Homebrew package manager
macos_brew_ls = { "efm-langserver", "texlab", "shellcheck", "shfmt" }

-- Language servers that will be installed using asdf-vm (applies for macOS and linux, doesn't apply for Windows)
asdf_vm_ls = { "pyright", "tailwindls" }

-- xclip: clipboard tool
-- xdotool for vimtex.vim
arch_linux_pkgs = {
  "github-cli",
  "xclip",
  "efm-langserver",
  "shmt",
  "vscode-html-language-server",
  "xdotool",
  "selene-linter",
}

--=======================================--
--              Setup Python             --
--=======================================--

-- PROVIDERS:

-- python 3.x.x
-- venv can be setup with:
-- python -m venv venv
-- pynvim package MUST be installed:
--    pip install pynvim
python3 = {}

-- PYTHON VENVS FOR LANGUAGE SERVERS

-- setup python venvs for language server

-- GOLANG

-- install packer plugins
-- TODO: invoke nvim from the command line using +PackerInstall
-- TODO: compile after using +PackerCompile

-- Install language serveers
-- install from lsp-updater directory

-- Extras
-- remove ensure installed from treesitter
