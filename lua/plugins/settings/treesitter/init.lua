-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "bibtex",
    "c",

    -- "comment",
    -- produces SERIOUS (unusable) lag in tsx, js, jsx files
    -- TODO: test it again
    -- see: https://github.com/nvim-treesitter/nvim-treesitter/issues/1267
    -- see: https://github.com/nvim-treesitter/nvim-treesitter/issues/1313
    -- see: https://github.com/nvim-treesitter/nvim-treesitter/issues/1275

    "css",
    "dockerfile",
    "graphql",
    "html",
    "javascript",

    -- "jsdoc", see:: https://github.com/nvim-treesitter/nvim-treesitter/issues/1275

    "julia",
    -- "latex", TODO: let vimtex handle this?
    "lua",
    "nix",
    "python",
    "regex", -- TODO: check how this works
    "rst",
    "ruby",
    "rust",
    "scss",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "vue",
    "yaml",
  },

  -- {{{ Default modules

  -- Consistent syntax highlighting.
  highlight = {
    enable = true, -- false will disable the whole extension
    language_tree = true, -- TODO: what is it for? Does it work?

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  -- Incremental selection based on the named nodes from the grammar.
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  -- Indentation based on treesitter for the = operator.
  -- NOTE: This is an EXPERIMENTAL feature.
  indent = {
    enable = true,
    disable = { "lua" },
  },

  -- Tree-sitter based folding. (Technically not a module because it's per windows and not per buffer.)
  -- TODO: configure it, https://github.com/nvim-treesitter/nvim-treesitter#folding

  -- }}}

  -- {{{ External modules

  -- nvim-ts-autotag config
  -- use treesitter to autoclose and autorename html tags
  autotag = { enable = true },

  -- nvim-ts-context-commentstring config:
  -- enable variable commentstrings
  -- useful for languages that mixes
  -- different syntaxes like:
  -- jsx, tsx and svelte,
  context_commentstring = { enable = true },

  -- nvim-ts-rainbow
  -- NOTE: can be a source of slowness
  rainbow = {
    enable = true,
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- 1000 -- Be careful with > 1000 lines files, int
  },

  -- autopairs = {enable = true}  -- windwp/nvim-autopairs,
  -- TODO: configure autopairs because it was annoying me more than helping

  -- vim-match-up
  -- experimental support for language syntax provided by tree-sitter.
  -- List of supported languages: https://github.com/andymass/vim-matchup/tree/master/after/queries
  matchup = { enable = true },

  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",

        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",

        ["ic"] = "@conditional.inner",
        ["ac"] = "@conditional.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },

  textsubjects = {
    enable = true,
    keymaps = {
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-container-outer",
    },
  },
  -- }}}
}
