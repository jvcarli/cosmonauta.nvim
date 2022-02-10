-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- LSP config is really a breaze, look how simple!!!

-- TODO: explore codelens support
-- See: https://github.com/neovim/neovim/pull/13165

local lspconfig = require "lspconfig"

-- {{{ Custom Lsp Attach
local custom_lsp_attach = function(client, bufnr)
  -- Uses LSP as the handler for Neovim built-in omnifunc (i_CTRL-X_CTRL-O)
  -- DISABLED in favor of nvim_cmp autocompletion plugin
  -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  -- These mappings only work inside a buffer with a LSP attached
  -- which is good because it won't affect default mappings when there isn't a LSP

  local opts = { remap = false, silent = true, buffer = bufnr }
  -- TODO: `buffer = bufnr` and `buffer = 0` seems in practice to mean the same thing
  -- find out if there's any difference
  -- buffer: means buffer handle
  -- buffer = bufnr makes it so the mapping will apply only for the buffer where there's a lsp attached

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

  -- Hover and help
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

  -- Workspace management
  -- TODO: explore lsp workspace management and how it works
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)

  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("v", "<leader>ca", vim.lsp.buf.range_code_action, opts)

  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.lsp.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.lsp.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

  vim.keymap.set("n", "<leader>so", function()
    return require("telescope.builtin").lsp_document_symbols()
  end, opts)

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
    on_attach = on_attach,
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
    local sumneko_binary_path = sumneko_root_path .. "/bin/" .. "/" .. sumneko_binary_cmd

    local lua_runtime_path = vim.split(package.path, ";")
    table.insert(lua_runtime_path, "lua/?.lua")
    table.insert(lua_runtime_path, "lua/?/init.lua")

    -- Disable default lua-language-server formatting in favor of using stylua via null-ls.nvim plugin
    -- TODO: research if lua-language-server formatting (it uses https://github.com/CppCXY/EmmyLuaCodeStyle) is better than stylua
    config.on_attach = function(client, _)
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

  -- if server == "tailwindcss" then
  -- TODO: add color support to tailwindcss server
  -- on_attach = function(client)
  --   -- [[ other on_attach code ]]

  -- BUG: TailwindCSS server is dumb and freaks out trying to attach to markdown files, wtf?
  -- BUG: TailwindCSS server tries to attach to almost any project  -- using only
  -- so root_dir is defined with files that must be present in a tailwind project
  -- config.root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts")
  -- end

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
