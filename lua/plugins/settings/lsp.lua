-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- LSP config is really a breaze, look how simple!!!

-- TODO: explore codelens support
-- See: https://github.com/neovim/neovim/pull/13165

local lspconfig = require "lspconfig"

-- {{{ on_attach
local on_attach = function(client, bufnr)
  require("lsp_signature").on_attach() -- NOTE: add in lsp client
  require("illuminate").on_attach(client) -- NOTE: add in lsp client

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>so",
    [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
    opts
  )

  -- if the language server has formatting capabilities format the buffer
  if client.resolved_capabilities.document_formatting then
    -- vim.lsp.buf.formatting() -- asynchronous formatting
    -- vim.lsp.buf.formatting_sync() -- synchronous formatting, better to avoid desync problems
    vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
  end
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
  "null-ls",
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
    local system_name

    if vim.fn.has "mac" == 1 then
      system_name = "macOS"
    elseif vim.fn.has "unix" == 1 then
      system_name = "Linux"
    elseif vim.fn.has "win32" == 1 then
      system_name = "Windows"
    else
      print "Unsupported system for sumneko"
    end

    -- set the path to the sumneko installation
    local sumneko_root_path = vim.fn.getenv "HOME" .. "/.local/share/nvim/nvim-lsp-language-servers/lua-language-server"
    local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

    local lua_settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }

    config.cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" }
    config.filetypes = { "lua" }
    config.log_level = 2
    config.settings = lua_settings
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

      -- no default maps, so you may want to define some here
      local opts = { silent = true }

      vim.api.nvim_buf_set_keymap(bufnr, "n", "gso", ":TSLspOrganize<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gsr", ":TSLspRenameFile<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gsi", ":TSLspImportAll<CR>", opts)
    end
  end
  -- }}}

  -- {{{ null ls
  if server == "null-ls" then
    local null_ls = require(server)
    local sources = {
      null_ls.builtins.diagnostics.vint, -- viml
      null_ls.builtins.diagnostics.codespell,
      null_ls.builtins.diagnostics.vale, -- TODO: add proselint rules emulated through vale, see https://github.com/jose-elias-alvarez/null-ls.nvim/pull/241
      null_ls.builtins.diagnostics.selene,
      null_ls.builtins.diagnostics.shellcheck,
      -- null_ls.builtins.diagnostics.pkgbuildlint, -- TODO: make pkgbuild shellcheck lint work
      null_ls.builtins.diagnostics.flake8,

      null_ls.builtins.formatting.rustywind,
      null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.shellharden, -- BUG: something is wrong with its formatting

      null_ls.builtins.formatting.shfmt.with {
        extra_args = {
          "-i", -- uses n spaces instead of the tab default
          vim.bo.shiftwidth, -- uses shiftwidth as arg to -i,
          "-ci", -- switch cases will be indented
          "-s", -- simplify the code
          "-bn", -- binary ops like && and | may start a line
        },
      },

      null_ls.builtins.formatting.prettierd.with {
        filetypes = {
          "html",
          "json",
          "yaml",
          "markdown",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
      },

      null_ls.builtins.code_actions.gitsigns,

      null_ls.builtins.formatting.codespell,
      -- null_ls.builtins.diagnostics.tidy, -- BUG: not working
    }
    null_ls.config {
      sources = sources,
    }
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