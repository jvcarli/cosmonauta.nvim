require("null-ls").setup {
  sources = {
    require("null-ls").builtins.diagnostics.vint, -- viml
    require("null-ls").builtins.diagnostics.codespell,
    require("null-ls").builtins.diagnostics.vale, -- TODO: add proselint rules emulated through vale, see https://github.com/jose-elias-alvarez/null-ls.nvim/pull/241
    require("null-ls").builtins.diagnostics.selene,
    require("null-ls").builtins.diagnostics.shellcheck,
    -- require("null-ls").builtins.diagnostics.pkgbuildlint, -- TODO: make pkgbuild shellcheck lint work
    require("null-ls").builtins.diagnostics.flake8,

    require("null-ls").builtins.formatting.rustywind,
    require("null-ls").builtins.formatting.stylua,
    -- require("null-ls").builtins.formatting.shellharden, -- BUG: something is wrong with its formatting

    require("null-ls").builtins.formatting.shfmt.with {
      extra_args = {
        "-i", -- uses n spaces instead of the tab default
        vim.bo.shiftwidth, -- uses shiftwidth as arg to -i,
        "-ci", -- switch cases will be indented
        "-s", -- simplify the code
        "-bn", -- binary ops like && and | may start a line
      },
    },

    require("null-ls").builtins.formatting.prettierd.with {
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

    require("null-ls").builtins.code_actions.gitsigns,

    require("null-ls").builtins.formatting.codespell,
    -- require("null-ls").builtins.diagnostics.tidy, -- TODO: add support for it
  },
}
