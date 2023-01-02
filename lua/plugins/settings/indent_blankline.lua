-- indent-blankline configuration
-- https://github.com/lukas-reineke/indent-blankline.nvim

require("indent_blankline").setup {
  char = "│",
  -- char_list = { "|", "¦", "┆", "┊" }, -- Too noisy

  context_char = "┃",
  -- context_char_blankline = "┃",

  -- char_blankline = "⤦", -- Too noisy
  -- char_list_blankline = { "|", "¦", "┆", "┊" }, -- Too noisy

  -- space_char_blankline = "⤦", -- Too noisy, but can be useful

  buftype_exclude = {
    "terminal",
    "nofile",
  },

  filetype_exclude = {
    "help",
    "startify",
    "man",
    "gitmessengerpopup",
    "dirbuf",
    "dirvish",
  },

  -- IDE like context display
  -- column char gets highlighted
  show_current_context = true,

  -- DON'T show current context start,
  -- that means don't use highlight groups for it!
  -- affects the LINE (be a function, a class, ...)
  -- that starts the indent. I found this too noisy.
  show_current_context_start = false,

  -- I find it misleading when set to true
  show_trailing_blankline_indent = false,

  -- The maximum indent level increase from line to line.
  -- Set this option to 1 to make aligned trailing multiline comments not
  -- create indentation.
  max_indent_increase = 1,

  -- BUG: This option is UNUSABLE with python, but is due its
  -- treesitter implementation, not indent_blankline itself.
  -- SEE: https://github.com/lukas-reineke/indent-blankline.nvim/issues/226
  --
  -- TODO: turn off for python only!
  -- TODO: convert to lua, how does v:true translate to lua?
  use_treesitter = false,

  -- Import option for highlighting indents which its start is not displayed
  -- in the buffer anymore, e.g.: long <div> in an html file.
  -- SEE: https://github.com/lukas-reineke/indent-blankline.nvim/issues/374
  --   NOTE: high numbers cause some lag in the editor
  -- TODO: find a suitable number
  viewport_buffer = 40, -- defaults to 10
}
