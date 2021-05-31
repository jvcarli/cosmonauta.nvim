require"nvim-treesitter.configs".setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true, -- false will disable the whole extension
        language_tree = true
    },
    indent = {enable = true},
    -- nvim-ts-autotag config:
    autotag = {enable = true},
    -- nvim-ts-context-commentstring config:
    -- enable variable commentstrings
    -- usefull for jsx, tsx and svelte
    context_commentstring = {enable = true},
    -- rainbow = {
    --     enable = true,
    --     extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    --     max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
    -- },
    autopairs = {enable = true}  -- windwp/nvim-autopairs
}
