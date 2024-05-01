-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- LSP config is really a breaze, look how simple!!!

-- TODO: I think config setup of lsp's can be cleaner if I use vim.tbl_deep_extend
--       SEE: https://github.com/neovim/neovim/blob/b455e0179b4288c69e6231bfcf8d1c132b78f2fc/runtime/lua/vim/lsp/util.lua#L1812

-- TODO: explore codelens support
-- SEE: https://github.com/neovim/neovim/pull/13165
-- SEE: https://www.reddit.com/r/neovim/comments/sp2lqq/how_to_run_these_suggested_actions/

-- NOTE: must come before lspconfig setup
require("neodev").setup {}

local lspconfig = require "lspconfig"
local lsp_keymaps = require("keymaps").lsp_keymaps
local is_mac = require("user.modules.utils").is_mac

local lsp_formatting = function(bufnr)
  -- Synchronous formatting, better to buffer syncing problems
  -- Asynchronous formatting, please DON'T, SEE: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#async-formatting
  -- NOTE: https://github.com/lukas-reineke/lsp-format.nvim could be used but it would another level
  --       of indirection and I prefer it the buffers to be sync formatted anyways.
  -- NOTE: when confused read https://www.reddit.com/r/neovim/comments/jvisg5/lets_talk_formatting_again/
  vim.lsp.buf.format {
    filter = function(client)
      -- apply whatever logic you want
      --
      -- If file path contains the word Exploring it means I'm exploring the directory.
      -- In this scenario I DON'T want to apply formatting on save because that could
      -- mess the git repository that I'm exploring.
      -- Otherwise format on save will be applied
      -- TODO: consider extracting current_file_path function to 'utils' lua module
      local current_file_path = vim.fn.resolve(vim.fn.expand "%:p")
      -- Case sensitivity doesn't matter for the comparison
      current_file_path = current_file_path:lower()
      -- TODO: include "/research/" in if not logic below
      if not current_file_path:find "/exploring/" then
        -- only using efm-langserver for languages that doesn't have native
        -- formatters in the language server
        return client.name == "efm"
      end
    end,
    bufnr = bufnr,
  }
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Custom attach example:
--   SEE: https://github.com/ChristianChiarulli/nvim/blob/aded29fdf43f7cc6ef976e348be213063fc330b0/lua/user/lsp/handlers.lua#L48-L56
-- {{{ Custom Lsp Attach
local lsp_on_attach = function(client, bufnr)
  -- keymaps to use with lspconfig (null-ls use some of them too when possible)
  lsp_keymaps(client, bufnr)

  if client.server_capabilities.colorProvider then
    -- taken from kabouzeid dotfiles
    require("user.modules.lsp-documentcolors").buf_attach(bufnr, { single_column = true })
  end

  -- if the language server has formatting capabilities synchronous format the buffer on save
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end
-- }}}

-- {{{ Available servers
local servers = {

  "cmake",
  "matlab_ls",
  "efm",
  "lua_ls",
  "tsserver", -- javascript, jsx, typescript and tsx
  "html",
  "pyright", -- TODO: see https://www.reddit.com/r/neovim/comments/sazbw6/python_language_servers/ for detailed setup
  "tailwindcss",
  "bashls",
  "emmet_ls", -- completion is working but it's kinda strange
  "vimls",
  "jsonls",
  "eslint", -- TODO: learn more about eslint lsp configuration options
  "svelte",
  "cssmodules_ls",
  "rust_analyzer",
  "clangd", -- TODO: cpp setup is more involved then interpreted languages. make it work properly
  --                 SEE: https://www.reddit.com/r/neovim/comments/tul8pb/lsp_clangd_warning_multiple_different_client/

  -- choosing between texlab and ltex-ls
  "texlab",
  -- "ltex", -- autocomplete doesn't seem to work.
  --         Has spelling mistake support (EN). Does it support portuguese?
}
-- }}}

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- SEE: https://github.com/kevinhwang91/nvim-ufo#installation
-- Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- default config (setup function for the language servers)
-- TODO: maybe change the name from default_config to default_setup
local function default_config()
  return {
    capabilities = capabilities,
    on_attach = lsp_on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
  }
end

-- local override_on_attach = function(on_attach_function, table_to_eval)
--   local default_on_attach = on_attach_function
--   on_attach_function = function(client, bufnr)
--     default_on_attach(client, bufnr)
--     for _, value in ipairs(table_to_eval) do
--       print(value)
--     end
--   end
--   return on_attach_function
-- end

-- {{{ Enable and configure servers
for _, server in ipairs(servers) do
  local config = default_config()

  -- yarn 2 / pnp support
  -- SEE: https://github.com/williamboman/nvim-lsp-installer/tree/main/lua/nvim-lsp-installer/servers/eslint
  -- {{{ lua_ls (which was renamed from sumneko_lua)

  if server == "lua_ls" then
    -- local lua_runtime_path = vim.split(package.path, ";")
    -- table.insert(lua_runtime_path, "lua/?.lua")
    -- table.insert(lua_runtime_path, "lua/?/init.lua")

    -- Disable default lua-language-server formatting in favor of using stylua via null-ls.nvim plugin
    -- TODO: research if lua-language-server formatting (it uses https://github.com/CppCXY/EmmyLuaCodeStyle)
    -- is better than Stylua (currently being used)
    local default_on_attach = config.on_attach
    local lua_config = {
      on_attach = function(client, bufnr)
        -- reuse default config.on_attach (for mappings, etc...)
        default_on_attach(client, bufnr)

        -- disable default lua-language-server formatting in favor of using prettierd via null-ls.nvim plugin
        -- TODO: disabling throught this seems to be sketchy!
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
      end,

      settings = {
        -- WARN: one ideally would use .luarc.json files instead of hardcoding setup here.
        -- TODO: unhardcode nvim related setup from here.
        --       SEE: https://github.com/sumneko/lua-language-server/wiki/Configuration-File#luarcjson
        Lua = {
          -- completion = {
          --   -- disable lua-language-server default snippets, good for using with luasnip
          --   keywordSnippet = "Disable",
          -- },
          -- runtime = {
          --   -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          --   version = "LuaJIT",
          --   -- Setup lua path
          --   path = lua_runtime_path,
          -- },
          -- diagnostics = {
          --   -- Get the language server to recognize `vim` globals
          --   globals = { "vim" },
          -- },
          workspace = {
            -- Make the server aware of Neovim runtime files
            -- library = vim.api.nvim_get_runtime_file("", true),

            -- Stop with "Do you need to configure your work environment as `luassert`?" message
            -- SEE: https://github.com/neovim/nvim-lspconfig/issues/1700
            -- SEE: https://www.reddit.com/r/neovim/comments/wgu8dx/configuring_neovim_for_l%C3%B6velua_i_always_get/
            checkThirdParty = false,
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }
    config = vim.tbl_deep_extend("force", config, lua_config)
  end

  -- }}}

  -- {{{ tsserver

  -- TODO: for using with yarn pnp see: https://github.com/neovim/neovim/issues/14867
  if server == "tsserver" then
    local default_on_attach = config.on_attach

    local tsserver_config = {
      -- Needed for inlayHints. Merge this table with your settings or copy
      -- it from the source if you want to add your own init_options.
      init_options = require("nvim-lsp-ts-utils").init_options,

      on_attach = function(client, bufnr)
        -- reuse default config.on_attach (for mappings, etc...)
        default_on_attach(client, bufnr)

        -- disable default tsserver formatting in favor of using prettierd via null-ls.nvim plugin
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false

        local ts_utils = require "nvim-lsp-ts-utils"

        ts_utils.setup {
          debug = false,
          disable_commands = false,
          enable_import_on_completion = false, -- applicable ONLY when using omnicompletion

          -- import all
          import_all_timeout = 5000, -- ms
          -- lower numbers = higher priority
          import_all_priorities = {
            same_file = 1, -- add to existing import statement
            local_files = 2, -- git files or files with relative path markers
            buffer_content = 3, -- loaded buffer content
            buffers = 4, -- loaded buffer names
          },
          import_all_scan_buffers = 100,
          import_all_select_source = false,
          -- if false will avoid organizing imports
          always_organize_imports = false,

          -- filter diagnostics
          -- TODO: learn more about this option
          filter_out_diagnostics_by_severity = {},
          filter_out_diagnostics_by_code = {},

          -- inlay hints
          -- show types as lens
          auto_inlay_hints = false, -- TODO: test it!
          inlay_hints_highlight = "Comment",
          inlay_hints_priority = 200, -- priority of the hint extmarks
          inlay_hints_throttle = 150, -- throttle the inlay hint request
          inlay_hints_format = { -- format options for individual hint kind
            Type = {},
            Parameter = {},
            Enum = {},
            -- Example format customization for `Type` kind:
            -- Type = {
            --     highlight = "Comment",
            --     text = function(text)
            --         return "->" .. text:sub(2)
            --     end,
            -- },
          },

          -- update imports on file move
          update_imports_on_move = true,
          require_confirmation_on_move = false,
          watch_dir = nil,
        }

        -- required to fix code action ranges and filter diagnostics
        ts_utils.setup_client(client)

        -- TSUtils mappings
        local opts = { silent = true, buffer = bufnr }

        vim.keymap.set("n", "gso", "<cmd>TSLspOrganize<CR>", opts)
        vim.keymap.set("n", "gsr", "<cmd>TSLspRenameFile<CR>", opts)
        vim.keymap.set("n", "gsi", "<cmd>TSLspImportAll<CR>", opts)
      end,
    }
    config = vim.tbl_deep_extend("force", config, tsserver_config)
  end
  -- }}}

  -- {{{ tailwindcss

  if server == "tailwindcss" then
    -- {{{ Add Hugo (https://gohugo.io) projects support:
    -- SEE:https://www.reddit.com/r/neovim/comments/skac4h/lsp_working_after_e/
    -- SEE:https://stackoverflow.com/questions/68347170/tailwindcss-lsp-for-neovim-root-dir-issue
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
    config.root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts", "tailwind.config.cjs")

    config.settings = {
      tailwindCSS = {
        validate = true,
        lint = {
          cssConflict = "warning",
          invalidApply = "error",
          invalidScreen = "error",
          invalidVariant = "error",
          invalidConfigPath = "error",
          invalidTailwindDirective = "error",
          recommendedVariantOrder = "warning",
        },
        classAttributes = {
          "class",
          "className",
          "classList",
          "ngClass",
        },

        -- SEE: taken from https://github.com/jaredh159/tailwind-react-native-classnames/issues/78#issuecomment-971856355
        experimental = {
          classRegex = {

            -- taken from: https://github.com/ben-rogerson/twin.macro/discussions/227
            "tw`([^`]*)", -- tw`...`
            'tw="([^"]*)', -- <div tw="..." />
            'tw={"([^"}]*)', -- <div tw={"..."} />
            "tw\\.\\w+`([^`]*)", -- tw.xxx`...`
            "tw\\(.*?\\)`([^`]*)", -- tw(Component)`...`

            -- Using javascript variables as TailwindCSS classes
            -- TODO: merge regexp when possible
            --
            -- unescaped expression: const \b\w+\b = ["']([^\["'\]]*)
            -- SEE: https://www.regextester.com/
            -- escaped expression:
            -- "const \\b\\w+\\b = [\"'](^\\[\"'\\]]*)", -- const anywordlenght = "..." OR const anywordlenght = '...'

            [[const \b\w+\b = \"([^\"]*)]], -- const anywordlenght = "..."
            [[const \b\w+\b = \'([^\']*)]], -- const anywordlenght = '...'

            [[let \b\w+\b = \"([^\"]*)]], -- let anywordlenght = "..."
            [[let \b\w+\b = \'([^\']*)]], -- let anywordlenght = '...'

            [[const \b\w+\b =\n\s*\"([^\"]*)]], -- const anywordlenght = "..." BUT prettier formatted
            [[const \b\w+\b =\n\s*\'([^\']*)]], -- const anywordlenght = '...' BUT pretiter formatted
            [[let \b\w+\b =\n\s*\"([^\"]*)]], -- let anywordlenght = "..." BUT prettier formatted
            [[let \b\w+\b =\n\s*\'([^\']*)]], -- let anywordlenght = '...' BUT pretiter formatted
          },
        },
      },
    }
  end

  -- }}}

  -- {{{ html langserver
  -- NOTE: using `npm install -g vscode-langservers-extracted`

  if server == "html" then
    local default_on_attach = config.on_attach
    local html_config = {
      on_attach = function(client, bufnr)
        -- reuse default config.on_attach (for mappings, etc...)
        default_on_attach(client, bufnr)

        -- disable default html formatting in favor of using prettierd via null-ls.nvim plugin
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
      end,

      -- TODO: check if these capabilites are working
      -- Enable (broadcasting) snippet capability for completion
      -- TODO: Why the using directly the below doesn't work?
      -- config.capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities = {
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true,
            },
          },
        },
      },
    }
    config = vim.tbl_deep_extend("force", config, html_config)
  end

  -- }}}

  -- {{{ emmet_ls
  if server == "emmet_ls" then
    -- TODO: find out why emmet_ls doesn't understand gohtmltmpl files
    config.filetypes = {
      "css",
      "html",
      "typescriptreact",
      "javascriptreact",
      -- "gohtmltmpl", -- BUG: doesn't work well
    }

    config.capabilities.textDocument.completion.completionItem.snippetSupport = true
  end

  -- }}}

  -- {{{ jsonls
  if server == "jsonls" then
    -- TODO: find out why emmet_ls doesn't understand gohtmltmpl files
    local default_on_attach = config.on_attach
    config.on_attach = function(client, bufnr)
      -- reuse default config.on_attach (for mappings, etc...)
      default_on_attach(client, bufnr)

      -- disable formatting
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false
    end
    config.settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    }

    config.capabilities.textDocument.completion.completionItem.snippetSupport = true
  end
  -- }}}

  -- {{{ clangd

  if server == "clangd" then
    -- BUG: annoying cland error when capabilities is not changed:
    --
    --      "warning: multiple different client offset_encodings detected for buffer, this is not supported yet"
    --      SEE: https://www.reddit.com/r/neovim/comments/wmj8kb/i_have_nullls_and_clangd_attached_to_a_buffer_c/
    --      SEE: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
    --      SEE: https://github.com/neovim/neovim/issues/14090#issuecomment-1012005684
    --      SEE: https://github.com/LunarVim/LunarVim/issues/2597
    --      WARN: Are there any side effects in doing this?
    -- config.capabilities.offsetEncoding = "utf-8" -- FIX: doesn't work
    --
    -- CAN BE A FIX TOO BY JUST SUPPRESSING THE MESSAGE
    -- SEE: https://www.reddit.com/r/neovim/comments/wmj8kb/i_have_nullls_and_clangd_attached_to_a_buffer_c/
    --
    local notify = vim.notify
    vim.notify = function(msg, ...)
      if msg:match "warning: multiple different client offset_encodings" then
        return
      end

      notify(msg, ...)
    end

    if is_mac then
      -- comes from Homebrew package manager
      -- brew install llvm, SEE: https://clangd.llvm.org/installation.html
      --
      -- command for clangd server
      -- SEE: https://stackoverflow.com/questions/59185976/how-to-install-clangd-on-mac
      config.cmd = { "/usr/local/opt/llvm/bin/clangd" }
    end
  end
  -- }}}

  -- {{{ cssmodules-language-server

  -- TODO: setup cssmodules-language-server configuration

  -- SEE: https://github.com/antonk52/cssmodules-language-server

  -- Known issue: if you have multiple LSP that provide hover and go-to-definition support,
  -- there can be races(example typescript and cssmodules-language-server work simultaneously).
  -- As a workaround you can disable definition in favor of implementation
  -- to avoid conflicting with typescript's go-to-definition.

  -- }}}

  if server == "matlab_ls" then
    config.settings = {
      matlab = {
        -- Indexing allows the extension to find and navigate between your MATLAB code files.
        -- You can disable indexing to improve the performance of the extension.
        -- To disable indexing, set the matlab.indexWorkspace setting to false.
        -- Disabling indexing can cause features such as code navigation
        -- not to function as expected.
        indexWorkspace = true, -- defaults to true in vscode and false in nvim-lspconfig
        installPath = "/home/development/MATLAB/R2023a", -- WARN: important! must be a valid install path
        matlabConnectionTiming = "onStart",
        telemetry = false,
      },
    }
  end

  -- {{{ efm-langserver
  if server == "efm" then
    -- register linters and formatters from efmls-configs.nvim
    local stylua = require "efmls-configs.formatters.stylua"
    -- TODO: setup prettier for markdown
    -- Another option, SEE: https://github.com/dprint/dprint
    local prettier = require "efmls-configs.formatters.prettier"

    local clang_format = require "efmls-configs.formatters.clang_format"

    local efm_languages = {
      lua = { stylua },
      c = { clang_format },
    }

    config.filetypes = vim.tbl_keys(efm_languages)

    config.settings = {
      rootMarkers = { ".git/" },
      languages = efm_languages,
    }

    config.init_options = {
      documentFormatting = true,
      documentRangeFormatting = true,
    }
  end
  -- }}}

  -- generic config for setting up the servers using nvim-cmp
  -- TODO: maybe I need to extend with vim.tbl_deep_extend or vim.tbl_extend because
  --       in some servers I've changed the default capabilities.
  config.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  lspconfig[server].setup(config)
end

-- }}}

-- {{{ Customizing how diagnostics are displayed
-- SEE: help on_publish_diagnostics for more advanced customization options.

-- TODO: configure show diagnostics on cursor
-- stylua: ignore
vim.diagnostic.config({
  -- Alternativaly, diagnostics can be seen using Lspsaga or Trouble.nvim
  virtual_text = false,     -- Virtual text can be REALLY distracting
  signs = false,            -- shows column signs for diagnostics
  underline = true,
  update_in_insert = false, -- updates diagnosting while on insert mode
  -- nvim-ts-autotag, set to 'true' if https://github.com/windwp/nvim-ts-autotag/issues/19 happens
  -- severity_sort = true, -- TODO: learn about severity_sort and how does it work
})

-- signs column icons when signs is set to true above
local signs = { Error = "󰅙 ", Warn = " ", Hint = "󰌶", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- }}}

-- WARN: external plugin for lsp based folding
require("ufo").setup()

-- TODO: setup pylance https://gist.github.com/nullchilly/91fb9d5bf410350d23dd8f4369e5183a
