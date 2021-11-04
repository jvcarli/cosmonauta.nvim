require"nvim-treesitter.configs".setup {
    ensure_installed = {
        "bash",
        "bibtex",
        "c",

        -- "comment",
        -- produces SERIOUS (unusable) lag in tsx, js, jsx files
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
        "latex",
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
        "yaml"},

    highlight = {
        enable = true, -- false will disable the whole extension
        language_tree = true,
    },

    indent = {
        enable = true,
        -- disable = {"tsx"}
    },

    -- nvim-ts-autotag config:
    -- use treesitter to autoclose and autorename html tags
    autotag = {enable = true},

    -- nvim-ts-context-commentstring config:
    -- enable variable commentstrings
    -- usefull for languages that mixes
    -- different syntaxes like:
    -- jsx, tsx and svelte,
    context_commentstring = {enable = true},

    -- rainbow = {
    --     enable = true,
    --     extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    --     max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
    -- },

    -- autopairs = {enable = true}  -- windwp/nvim-autopairs,
    -- TODO: configure autopairs because it was annoying me more than helping

    -- matchup = {
    --     enable = true,
    -- }
}
