-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- Golang templates grammar for tree-sitter
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = { "src/parser.c" },
  },
  filetype = "gotmpl",
  used_by = {
    "gohtmltmpl",
    "gotexttmpl",
    "gotmpl",
    "yaml", -- SEE: https://github.com/ngalaiko/tree-sitter-go-template/issues/1
  },
}

require("nvim-treesitter.configs").setup {
  -- TODO: check if ensure_installed really impacts performance?
  ensure_installed = {
    "bash",
    "bibtex",
    "c",

    -- "comment", produces SERIOUS (unusable) lag in tsx, js, jsx files
    --   TODO: test it again
    --   SEE: https://github.com/nvim-treesitter/nvim-treesitter/issues/1267
    --   SEE: https://github.com/nvim-treesitter/nvim-treesitter/issues/1313
    --   SEE: https://github.com/nvim-treesitter/nvim-treesitter/issues/1275
    --   SEE: https://www.reddit.com/r/neovim/comments/ywql5v/paintnvim_simple_neovim_plugin_to_easily_add/

    "cpp",
    "css",
    "diff",
    "dockerfile",
    "git_rebase",
    "gitcommit", -- depends on git_rebase
    -- "gotmpl", -- TODO: testing
    "graphql",
    "help",
    "html",
    "javascript",
    -- "jsdoc", -- SEE: https://github.com/nvim-treesitter/nvim-treesitter/issues/1275
    "json",
    "json5",
    "julia",

    -- "latex", -- NOTE: let vimtex handles this because even tho vimtex is slower than treesitter it is better
    --                   SEE: https://github.com/latex-lsp/tree-sitter-latex/issues/6

    "lua",
    "make", -- makefile
    "markdown",
    "markdown_inline",
    "nix",
    "python",
    "query", -- for TSPlayground, TODO: check if this query cause slowness
    "regex", -- TODO: check how this works
    "rst",
    "ruby",
    "rust",
    "scss",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "vim",
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
      init_selection = "gni",
      node_incremental = "gnn",
      scope_incremental = "gns",
      node_decremental = "gnp",
    },
  },

  -- Indentation based on treesitter for the = operator.
  -- NOTE: This is an EXPERIMENTAL feature.
  indent = {
    enable = true,
    disable = {
      -- "lua",
      -- "python", -- treesitter python indent is not good
    },
  },

  -- Tree-sitter based folding. (Technically not a module because it's per windows and not per buffer.)
  -- TODO: configure it, https://github.com/nvim-treesitter/nvim-treesitter#folding

  -- }}}

  -- {{{ External modules

  refactor = {
    highlight_definitions = {
      enable = false, -- NOTE: using vim-illuminate instead
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = false,
    },
    -- Highlights the block from the current scope where the cursor is.
    highlight_current_scope = { enable = false },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        -- TODO: find good mappings the functions below:
        -- alt (meta) mappings can conflict with terminal ones
        -- goto_next_usage = "]g",
        -- goto_previous_usage = "[g",
      },
    },
  },

  -- nvim-ts-autotag config
  -- use treesitter to autoclose and autorename html tags
  autotag = {
    enable = true,
    filetypes = {
      "html",
      "gotmpl", -- NOTE: testing
      "javascript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "rescript",
    },
  },

  -- nvim-ts-context-commentstring config:
  -- enable variable commentstrings
  -- useful for languages that mixes
  -- different syntaxes like:
  -- jsx, tsx and svelte,
  context_commentstring = {
    enable = true,

    -- Disable CursorHold autocommand of this plugin
    -- required for integration with Comment.nvim
    enable_autocmd = false,
  },

  -- autopairs = {enable = true}  -- windwp/nvim-autopairs,
  -- TODO: configure autopairs because it was annoying me more than helping

  -- vim-match-up
  -- List of supported languages: https://github.com/andymass/vim-matchup/tree/master/after/queries
  -- BUG: does it cause slowness on comments on some languages? (lua only)
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
        ["]c"] = "@conditional.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
        -- ["]C"] = "@conditional.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[c"] = "@conditional.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
        -- ["[C"] = "@conditional.outer",
      },
    },
  },

  textsubjects = {
    enable = true,
    keymaps = {
      -- it won't conflict with repeat.vim, as repeat.vim uses only a normal mode mapping
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-container-outer",
    },
  },

  -- TSPlayground module
  -- TODO: find out how this works
  -- SEE:https://github.com/nvim-treesitter/playground#query-linter

  playground = {
    enable = false,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },

  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },

  -- RRethy/nvim-treesitter-endwise
  -- Wisely add "end" in Ruby, Vimscript, Lua, etc.
  -- Tree-sitter aware alternative to tpope's vim-endwise
  endwise = {
    enable = true,
  },

  -- }}}
}
