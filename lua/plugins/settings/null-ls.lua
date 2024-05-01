local null_ls = require "null-ls"
local null_ls_sources = {

  -- builtins

  -- null_ls.builtins.diagnostics.codespell, -- WARN: see how to selectively disable on languages with pt_Br lang
  --
  -- SEE: https://github.com/jose-elias-alvarez/null-ls.nvim/pull/1154
  -- SEE: related https://github.com/f3fora/cmp-spell
  -- null_ls.builtins.diagnostics.cspell, -- NOTE: seems to work slow (gotta love javascript), at least on my downclocked macbook

  null_ls.builtins.diagnostics.vale.with {
    -- TODO: add proselint rules emulated through vale, see https://github.com/jose-elias-alvarez/null-ls.nvim/pull/241
    -- TODO: add more rules to vale, prefering it to vim native spelling when possible

    -- vale doesn't follow XDG_CONFIG_HOME, so we make it use a custom config location
    -- SEE: https://github.com/errata-ai/vale/issues/211
    extra_args = { "--config", vim.fn.expand "~/.config/vale/vale.ini" },
  },

  null_ls.builtins.formatting.rustfmt,
  null_ls.builtins.formatting.clang_format, -- NOTE: testing
  null_ls.builtins.formatting.stylua.with {
    condition = function(utils)
      return utils.root_has_file { "stylua.toml", ".stylua.toml" }
    end,
  },
  null_ls.builtins.formatting.shellharden,
  null_ls.builtins.formatting.black.with {
    condition = function(utils)
      -- SEE: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Source-specific-Configuration#specifying-edition for a example
      -- SEE: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#conditional-sources
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

  --  TODO: setup prettier to prefer local installed prettier instead of relying
  --        on a global installed one.
  --        SEE: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
  null_ls.builtins.formatting.prettierd.with {
    -- If you have locally installed prettier in your package, it will use that.
    -- Otherwise, it will use the one bundled with prettierd itself.
    filetypes = {
      "html",
      "json",
      -- "yaml", NOTE: removed yaml while I'm configuring allacritty
      "markdown", -- NOTE: find a better solution for markdown formatting
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
  },

  -- A simple wrapper around `awk` to remove trailing whitespace.
  null_ls.builtins.formatting.trim_whitespace.with {
    -- WARN: Use only for languages that doesn't have a stablished formatting solution
    -- NOTE: default is off, i.e. no filetypes at all
    filetypes = {
      "tmux",
      "vim",
    },
  },
  null_ls.builtins.diagnostics.trail_space.with {
    -- WARN: Use only for languages where lsp or other linting mechanisms don't complain
    --       about trailing whitespaces
    -- NOTE: default is off, i.e. no filetypes at all

    filetypes = {
      "lua",
      "tmux",
      "vim",
    },
  },

  -- (La)tex formatting
  -- Loading order of latexnindent.pl formatter:
  --   SEE: https://latexindentpl.readthedocs.io/en/latest/sec-indent-config-and-settings.html#fig-loadorder
  --   Basically it ALWAYS will load defaultSettings.yaml first
  --     On macos this file is located at /usr/local/Cellar/latexindent/3.19/libexec/bin/defaultSettings.yaml
  --     if latexindent was installed using Homebrew.
  --   After that it will search for USER settings. I don't set USER settings on purpose
  --   After that it will search for localSettings.yaml if latexindent is called using:
  --     `$ latexindent -l`
  --   Last but not least it will search for command line options set using the -y switch.
  null_ls.builtins.formatting.latexindent.with {
    extra_args = {
      [[-l=]] .. vim.fn.expand "~/.config/latexindent/latexindent.yaml", -- WARN: hardcoding it because i don't have the time to setup it properly yet
      "-m", -- allow line breaks
    },
  },

  -- root is giving problems because i use src directory usually instead of the working directory
  -- TODO: make chktex directory be the one that contains the main.tex file
  -- SEE: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
  null_ls.builtins.diagnostics.chktex,

  -- WARN: use markdownlint for diagnostics not for formatting.
  --       for formatting use Prettier.
  -- TODO: setup markdownlint
  -- null_ls.builtins.diagnostics.markdownlint,

  -- TODO: setup markdownlint_cli2 and compare it with regular markdownlint
  --  null_ls.builtins.diagnostics.markdownlint_cli2

  -- TODO: setup commitlint
  -- null_ls.builtins.diagnostics.commitlint,

  -- TODO: setup cbfmt
  --       cbfmt is a tool to format codeblocks inside markdown and org documents
  null_ls.builtins.formatting.cbfmt,

  -- TODO: lower priority code actions,
  -- SEE: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/630
  -- SEE: https://www.reddit.com/r/neovim/comments/syrkkc/was_someone_able_to_sort_code_actions_sources_for/
  -- TODO: include plugin existence check

  -- null_ls.builtins.diagnostics.pkgbuildlint, -- arch pkgbuildlint  TODO: add support for it
  -- null_ls.builtins.diagnostics.tidy, -- html tidy TODO: add support for it
}

-- CODE ACTIONS
-- external plugin code actions
-- TODO: guard it!
table.insert(null_ls_sources, null_ls.builtins.code_actions.gitsigns)

-- TODO: guard it!
table.insert(null_ls_sources, null_ls.builtins.code_actions.refactoring)
