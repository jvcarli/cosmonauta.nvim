-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
-- lspconfig for languages server protocols
-- see: https://github.com/neovim/nvim-lspconfig 
-- see: https://microsoft.github.io/language-server-protocol/implementors/servers/

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local utils = require"utils"
local configs = require("lspconfig/configs")

-- local M = {}

--  {{{ LSP Completion symbols
vim.lsp.protocol.CompletionItemKind = {
    " [text]",
    " [method]",
    " [function]",
    " [constructor]",
    "ﰠ [field]",
    " [variable]",
    " [class]",
    " [interface]",
    " [module]",
    " [property]",
    " [unit]",
    " [value]",
    " [enum]",
    " [key]",
    "﬌ [snippet]",
    " [color]",
    " [file]",
    " [reference]",
    " [folder]",
    " [enum member]",
    " [constant]",
    " [struct]",
    "⌘ [event]",
    " [operator]",
    "♛ [type]"
}
-- }}}

-- M.symbol_kind_icons = {
--     Function = "",
--     Method = "",
--     Variable = "",
--     Constant = "",
--     Interface = "",
--     Field = "ﰠ",
--     Property = "",
--     Struct = "",
--     Enum = "",
--     Class = ""
-- }

-- M.symbol_kind_colors = {
--     Function = "green",
--     Method = "green",
--     Variable = "blue",
--     Constant = "red",
--     Interface = "cyan",
--     Field = "blue",
--     Property = "blue",
--     Struct = "cyan",
--     Enum = "yellow",
--     Class = "red"
-- }

-- on_attach function is invoked by neovim lspconfig
-- it is executed when a client (neovim) is attached
-- to a language server (such as efm-langserver, tsserver, etc.)
local on_attach = function(client)
    -- if the language server has formatting capabilities
    -- invoke it when saving.
    -- This will reformat the whole buffer
    -- Useful when using formatters such as:
    -- prettier, black, svelte-language-server built in formatter
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
        vim.api.nvim_command [[augroup END]]
    end

    -- enables shortcut for go to definition
    -- if the language server has support for it
    if client.resolved_capabilities.goto_definition then
        utils.map("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {buffer = true})
    end

    --
    -- TODO: add shortcuts for hover and find references
    -- if client.resolved_capabilities.hover then
    --     utils.map("n", "<CR>", "<cmd>lua vim.lsp.buf.hover()<CR>", {buffer = true})
    -- end
    -- if client.resolved_capabilities.find_references then
    --     utils.map(
    --         "n",
    --         "<Space>*",
    --         ":lua require('lists').change_active('Quickfix')<CR>:lua vim.lsp.buf.references()<CR>",
    --         {buffer = true}
    --     )
    -- end
    -- TODO: add shortcuts for rename
    -- if client.resolved_capabilities.rename then
    --     utils.map("n", "<Space>rn", "<cmd>lua require'lsp.rename'.rename()<CR>", {silent = true, buffer = true})
    -- end

    -- utils.map("n", "<Space><CR>", "<cmd>lua require'lsp.diagnostics'.line_diagnostics()<CR>", {buffer = true})

end

-- Formatters (efm-langserver) {{{
-- diagnostic-languageserver (deprecated in favor of efm-langserver)

local prettier = require "efm/prettier"
local black = require "efm/black"
local shellcheck = require "efm/shellcheck"
local eslint = require "efm/eslint"
-- local luafmt = require "efm/luafmt"

-- efm-langserver main setup
lspconfig.efm.setup{
    init_options = {documentFormatting = true},
    on_attach = on_attach,
    -- filetypes = {"python", "lua"},
    filetypes = {
        "python",
        "typescript",
        "typescriptreact",
        "javascript",
        "javascriptreact",
        "yaml",
        "json",
        "html",
        "scss",
        "css",
        "markdown",
        "sh",
    },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            python = {black},
            typescript = {prettier, eslint},
            typescriptreact = {prettier, eslint},
            javascript = {prettier, eslint},
            javascriptreact = {prettier, eslint},
            yaml = {prettier},
            json = {prettier},
            html = {prettier},
            scss = {prettier},
            css = {prettier},
            markdown = {prettier},
            sh = {shellcheck}
        }
    }
}
-- lspconfig.efm.setup {
--     cmd = {"efm-langserver"},
--     root_dir = root_pattern(".git"),
--     filetypes = vim.tbl_keys(efm_languages),
--     init_options = {documentFormatting = true, codeAction = true},
--     settings = {languages = efm_languages},
-- }

-- local prettier = {
--   lintStdin = true,
--   lintFormats = {"%f:%l:%c: %m"},
--   lintIgnoreExitCode = true,
--   formatCommand = "prettier",
--   formatStdin = true
-- }
-- 
-- lspconfig.tsserver.setup {
--   on_attach = function(client)
--     if client.config.flags then
--       client.config.flags.allow_incremental_sync = true
--     end
--     client.resolved_capabilities.document_formatting = false
--     set_lsp_config(client)
--   end
-- }
--
-- lspconfig.efm.setup {
--   on_attach = function(client)
--     client.resolved_capabilities.document_formatting = true
--     client.resolved_capabilities.goto_definition = false
--     set_lsp_config(client)
--   end,
--   root_dir = function()
--     if not prettier_config_exists() then
--       return nil
--     end
--     return vim.fn.getcwd()
--   end,
--   settings = {
--     languages = {
--       javascript = {prettier},
--       javascriptreact = {prettier},
--       ["javascript.jsx"] = {prettier},
--       typescript = {prettier},
--       ["typescript.tsx"] = {prettier},
--       typescriptreact = {prettier}
--     }
--   },
--   filetypes = {
--     "html",
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescript.tsx",
--     "typescriptreact"
--   },
-- }
-- 
-- local function eslint_config_exists()
--   local prettierrc = vim.fn.glob(".prettierrc*", 0, 1)
-- 
--   if not vim.tbl_isempty(prettierrc) then
--     return true
--   end
-- 
--   if vim.fn.filereadable("package.json") then
--     if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
--       return true
--     end
--   end
-- 
--   return false
-- end

-- }}}

-- {{{ vscode html-lang-server
-- TODO: make vscode-html-langserver work
-- https://github.com/vscode-langservers/vscode-html-languageserver-bin
lspconfig.html.setup {on_attach = on_attach}
    
-- }}}

-- {{{ TSServer - Typescript server
lspconfig.tsserver.setup {
    -- See: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#tsserver
    -- Use globally installed typescript-language-server
    -- One hardcoded PATH or FULL PATH CAN'T BE declared MANUALLY
    -- because asdf WILL GET CONFUSED and won't find the
    -- `typescript-language-server` cmd when there's a 
    -- .tool-versions file in the current working directory.
    --
    -- tsserver dependencies (nodejs): typescript and typescript-language-server
    -- install them GLOBALLY in EVERY asdf managed NodeJS with:
    -- `npm install -g typescript typescript-language-server`
    cmd = {"typescript-language-server", "--stdio" },
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false -- turns off tsserver document formatting in favor of efm-langserver
        require "nvim-lsp-ts-utils".setup {} -- use jose-elias-alvarez/nvim-lsp-ts-utils enhancer
    end

}
-- }}}

-- {{{ svelte-language-server
-- You MUST install svelteserver GLOBALLY in every asdf managed NodeJs with:
-- npm install -g svelte-language-server
lspconfig.svelte.setup{
    on_attach = on_attach,
    cmd = {"svelteserver", "--stdio"},
    filetypes = { "svelte" }
}

-- }}}

-- {{{ TailwindCSS language server
-- TODO: configure tailwindls
-- }}}

-- {{{ Bash language server
-- https://github.com/bash-lsp/bash-language-server
lspconfig.bashls.setup {on_attach = on_attach}
-- }}}

-- {{{ Python language servers

-- Microsoft Pyright
-- https://github.com/microsoft/pyright
lspconfig.pyright.setup {
    cmd = {"pyright-langserver", "--stdio"},
}

-- jedi_language_server
-- see: https://github.com/pappasam/jedi-language-server 
-- lspconfig.jedi_language_server.setup{
--    cmd = {"/Users/development/.local/share/nvim/nvim-lsp-language-servers/jedi-language-server/venv/bin/jedi-language-server"},
-- }

-- palantir/pyls - python-language-server
lspconfig.pyls.setup{
    -- see: https://www.reddit.com/r/neovim/comments/jhgkid/disable_pyls_linting_for_nvm_lsp/
    cmd = {"/Users/development/.local/share/nvim/nvim-lsp-language-servers/python-language-server/venv/bin/pyls"},
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false -- remove formatting capabilitis so it doesn't conficlit with efm/black
    end,
    settings = {
        pyls = {
            plugins = {
                pycodestyle =  {
                    enabled = true,
                    ignore = {
                        "E501" -- E501 line too long error: removed in favor of python Black formatter
                    }
                },
                pydocstyle = {
                    enabled = true -- disabled by default
                },
                -- pylint =  {
                --     enabled = false,
                -- },
                autopep8 = {
                    enabled = false, -- disabled in favor of Black formatter
                },
                yapf = {
                    enabled = false, -- disabled in favor of Black formatter

                }
            }
        }
    }
}

-- }}}

-- {{{ gopls - Golang official language server
-- TODO: asdf install script for every asdf managed golang version
-- See: https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-v050
lspconfig.gopls.setup {
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
          staticcheck = true,
        },
    },
}
-- }}}

-- {{{ Lua language server
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local sumneko_root_path = '/Users/development/.local/share/nvim/nvim-lsp-language-servers/lua-language-server' -- TODO: should the full path be given?
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    filetypes = { "lua" },
    log_level = 2,
    -- root_dir = root_pattern(".git") or bufdir,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

-- }}}

-- return M -- ????
