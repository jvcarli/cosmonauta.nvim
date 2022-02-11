-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- LSP config is really a breaze, look how simple!!!

-- TODO: explore codelens support
-- See: https://github.com/neovim/neovim/pull/13165

local lspconfig = require "lspconfig"
local lsp_keymaps = require "keymaps"

-- {{{ Custom Lsp Attach
local custom_lsp_attach = function(client, bufnr)
  -- keymaps to use with lspconfig (null-ls use some of them too when possible)
  lsp_keymaps(bufnr)

  -- Thirdy-party LSP addons
  require("lsp_signature").on_attach()
  require("illuminate").on_attach(client)
end
-- }}}

-- {{{ Available servers
local servers = {
  "sumneko_lua",
  "tsserver", -- javascript, jsx, typescript and tsx
  "html",
  "pyright",
  "tailwindcss",
  "pyright",
  "bashls",
  "emmet_ls", -- completion is working but it's kinda strange
  "vimls",
  "eslint", -- TODO: learn more about eslint lsp configuration options
}
-- }}}

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- default config
local function default_config()
  return {
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
  }
end

-- {{{ Enable and configure servers
for _, server in ipairs(servers) do
  local config = default_config()

  -- {{{ sumneko_lua

  if server == "sumneko_lua" then
    local sumneko_binary_cmd

    if vim.fn.has "mac" or "unix" == 1 then
      sumneko_binary_cmd = "lua-language-server"
    elseif vim.fn.has "win32" == 1 then
      sumneko_binary_cmd = "lua-language-server.exe"
    else
      print "Unsupported system for sumneko"
    end

    -- set the path of the language server installation
    local sumneko_root_path = vim.fn.getenv "HOME" .. "/.local/share/nvim/nvim-lsp-language-servers/lua-language-server"
    -- set path of the language server binary
    local sumneko_binary_path = sumneko_root_path .. "/bin/" .. sumneko_binary_cmd

    local lua_runtime_path = vim.split(package.path, ";")
    table.insert(lua_runtime_path, "lua/?.lua")
    table.insert(lua_runtime_path, "lua/?/init.lua")

    -- Disable default lua-language-server formatting in favor of using stylua via null-ls.nvim plugin
    -- TODO: research if lua-language-server formatting (it uses https://github.com/CppCXY/EmmyLuaCodeStyle)
    -- is better than Stylua (currently being usedo)
    local default_on_attach = config.on_attach
    config.on_attach = function(client, bufnr)
      -- reuse default config.on_attach (for mappings, etc...)
      default_on_attach(client, bufnr)

      -- disable default tsserver formatting in favor of using prettierd via null-ls.nvim plugin
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end

    config.cmd = { sumneko_binary_path }
    config.settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup lua path
          path = lua_runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize `vim` and `packer_plugins` globals
          globals = { "vim", "packer_plugins" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }
  end

  -- }}}

  -- {{{ tsserver

  if server == "tsserver" then
    config.on_attach = function(client, bufnr)
      -- disable default tsserver formatting in favor of formatting via null-ls
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false

      local ts_utils = require "nvim-lsp-ts-utils"

      -- stylua: ignore
      ts_utils.setup {
        debug = false,
        disable_commands = false,
        enable_import_on_completion = false, -- applicable ONLY when using omnicompletion
                                             -- coq_nvim supports it
                                             -- nvim_cmp supports it too
        -- import all
        import_all_timeout = 5000, -- ms
        import_all_priorities = {
          buffers = 4, -- loaded buffer names
          buffer_content = 3, -- loaded buffer content
          local_files = 2, -- git files or files with relative path markers
          same_file = 1, -- add to existing import statement
        },
        import_all_scan_buffers = 100,
        import_all_select_source = false,

        -- eslint
        -- TODO: disable because eslint lsp is being used instead
        eslint_enable_code_actions = false,
        eslint_enable_disable_comments = false,
        eslint_bin = "eslint",
        eslint_enable_diagnostics = false,
        eslint_opts = {},

        -- formatting
        enable_formatting = true,
        formatter = "prettierd",
        formatter_opts = {},

        -- update imports on file move
        update_imports_on_move = true,
        require_confirmation_on_move = false,
        watch_dir = nil,

        -- filter diagnostics
        filter_out_diagnostics_by_severity = {},
        filter_out_diagnostics_by_code = {},
      }

      -- required to fix code action ranges and filter diagnostics
      ts_utils.setup_client(client)

      -- TSUtils mappings
      local opts = { silent = true, buffer = bufnr }

      vim.keymap.set("n", "gso", "<cmd>TSLspOrganize<CR>", opts)
      vim.keymap.set("n", "gsr", "<cmd>TSLspRenameFile<CR>", opts)
      vim.keymap.set("n", "gsi", "<cmd>TSLspImportAll<CR>", opts)
    end
  end
  -- }}}

  -- {{{ tailwindcss

  if server == "tailwindcss" then
    -- TODO: add color support to tailwindcss server

    -- {{{ Add Hugo (https://gohugo.io) projects support:
    -- see:https://www.reddit.com/r/neovim/comments/skac4h/lsp_working_after_e/
    -- see:https://stackoverflow.com/questions/68347170/tailwindcss-lsp-for-neovim-root-dir-issue
    local tailwindcssls_default_config = require("lspconfig.server_configurations.tailwindcss").default_config

    local tailwindcssls_default_filetypes = tailwindcssls_default_config.filetypes
    local tailwindcss_default_userLanguages = tailwindcssls_default_config.init_options.userLanguages

    -- add `gohtmltmpl` to default tailwindcssls filetypes
    table.insert(tailwindcssls_default_filetypes, "gohtmltmpl")
    -- add `gohtmltmpl` key to userLanguages and `gohtml` as its value,
    -- which will alias `gohtmltmpl` to `gohtml`, that is already recognized by tailwindcssls:
    tailwindcss_default_userLanguages.gohtmltmpl = "gohtml"
    -- }}}

    -- Attach TailwindCSS language server to ONLY TailwindCSS projects
    config.root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts")

    -- Sometimes we don't want to attach to a server on purpose, in this case `vim.notify` will warn use
    -- I find it annoying so I disabled it:
    -- HACK: This is hackishy, but it works and is better than overriding lspconfig module directly
    -- because it would be difficult to track changes in nvim-lspconfig core.
    -- It is also cleaner than defining an autocmd for enabling the server (using <cmd>LspStart)
    -- see: https://www.reddit.com/r/neovim/comments/sldn6e/help_tailwindcss_lsp_tries_to_attach_to_almost/
    -- see: https://www.reddit.com/r/neovim/comments/rpcrhr/lsp_anyway_to_not_attach_a_server_if_the_root/

    -- disable autostart to ensure the server will be only started on
    -- tailwindcss projects
    config.autostart = false -- see: https://github.com/neovim/nvim-lspconfig/pull/721

    local search_ancestors = lspconfig.util.search_ancestors
    local is_file = lspconfig.util.path.is_file
    local path_join = lspconfig.util.path.join
    local current_path = vim.fn.getcwd() -- TODO: this could be a problem if current_path IS NOT the project_root

    local function find_tailwind_config_ancestor(startpath)
      -- see: https://github.com/neovim/nvim-lspconfig/issues/1221
      return search_ancestors(startpath, function(path)
        if is_file(path_join(path, "tailwind.config.js")) or is_file(path_join(path, "tailwind.config.ts")) then
          config.autostart = true -- override autostart
        end
      end)
    end

    find_tailwind_config_ancestor(current_path)
  end

  -- }}}

  -- {{{ html langserver

  if server == "html" then
    -- Enable (broadcasting) snippet capability for completion
    config.capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- using npm install -g vscode-langservers-extracted
  end

  -- }}}

  if packer_plugins["coq_nvim"] and packer_plugins["coq_nvim"].loaded then
    -- generic config for setting up the servers using coq nvim
    local coq = require "coq"
    lspconfig[server].setup(coq.lsp_ensure_capabilities(config))
  elseif packer_plugins["nvim-cmp"] and packer_plugins["nvim-cmp"].loaded then
    -- generic config for setting up the servers using nvim-cmp
    config.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    lspconfig[server].setup(config)
  else -- just regular omnicompletion
    lspconfig[server].setup(config)
  end
end
-- }}}

-- {{{ Customizing how diagnostics are displayed
-- See: help on_publish_diagnostics for more advanced customization options.

-- TODO: configure show diagnostics on cursor
-- stylua: ignore
vim.diagnostic.config({
  -- Alternativaly, diagnostics can be seen using Lspsaga or Trouble.nvim
  virtual_text = false, -- Virtual text can be REALLY distracting
  signs = false, -- shows column signs for diagnostics
  underline = true,
  update_in_insert = false, -- updates diagnosting while on insert mode
                          -- nvim-ts-autotag, set to 'true' if https://github.com/windwp/nvim-ts-autotag/issues/19 happens
  -- severity_sort = false, TODO: learn about severity_sort and how does it work
})

-- signs column icons when signs is set to true above
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- }}}
