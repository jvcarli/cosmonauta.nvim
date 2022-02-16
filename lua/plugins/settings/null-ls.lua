local null_ls = require "null-ls"

local null_ls_keymaps = require("keymaps").lsp_keymaps

local null_ls_sources = {

  -- TODO: restrict null-ls to specific cases, so git history won't be all messed up
  -- in repos you want to contribute but don't own or when they don't follow the same style guide as you.
  -- see: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#conditional-sources

  null_ls.builtins.diagnostics.vint, -- viml
  null_ls.builtins.diagnostics.codespell,
  null_ls.builtins.diagnostics.vale, -- TODO: add proselint rules emulated through vale, see https://github.com/jose-elias-alvarez/null-ls.nvim/pull/241
  null_ls.builtins.diagnostics.selene,
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.diagnostics.flake8,

  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.shellharden,
  null_ls.builtins.formatting.black.with {
    condition = function(utils)
      -- see: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Source-specific-Configuration#specifying-edition for a example
      -- see: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#conditional-sources
      --  TODO: only format when black package is present in the project
      -- by parsing a pyproject.toml, setup.py, or requirements.txt file
      return utils.root_has_file { "pyproject.toml" }
    end,
  },
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
    -- If you have locally installed prettier in your package, it will use that.
    -- Otherwise, it will use the one bundled with prettierd itself.
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

  -- null_ls.builtins.diagnostics.pkgbuildlint, -- arch pkgbuildlint  TODO: add support for it
  -- null_ls.builtins.diagnostics.tidy, -- html tidy TODO: add support for it
}

local null_ls_on_attach = function(client, bufnr)
  -- keymaps to use with lspconfig (lspconfig use some of them when possible)
  null_ls_keymaps(client, bufnr)

  -- if the language server has formatting capabilities format the buffer on save
  if client.resolved_capabilities.document_formatting then
    -- Asynchronous formatting, please DON'T,  See: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Async-formatting
    -- vim.lsp.buf.formatting_sync() -- synchronous formatting, better to avoid desync problems
    vim.cmd [[
        augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
      ]]
  end
end

null_ls.setup {
  sources = null_ls_sources,
  on_attach = null_ls_on_attach,
}
