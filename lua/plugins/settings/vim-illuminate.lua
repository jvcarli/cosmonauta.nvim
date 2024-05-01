require("illuminate").configure {
  providers = {
    -- "lsp",
    "treesitter",
    -- "regex",
  },

  -- Vim illuminate will delay before highlighting,
  -- this is not lag, it is to avoid the jarring experience of things illuminating too fast.
  -- Default is 100 milliseconds
  delay = 200, -- in ms

  filetypes_denylist = {
    "dirvish",
    "fugitive",
    "qf", -- Neovim builtin quickfix and loclist
    "dirbuf",
    "help",
  },

  -- modes to not illuminate, this overrides modes_allowlist
  modes_denylist = {
    "i", -- Don't highlight on insert mode because it's annoying
  },

  -- minimum number of matches required to perform highlighting
  min_count_to_highlight = 2, -- highlighting one occurrence is useless
}
