local gitsigns_mappings = require("keymaps").gitsigns_mappings

require("gitsigns").setup {
  signs = {

    -- U+258C: Left Half Block Char -> ▌ <-
    -- U+258E: Left one quarter block char --> ▎<-
    -- U+258B: Left Five Eighths Block char -> ▋ <-
    -- U+258A: Left three quarters block -->▊<-

    -- U+2590: Right Half Block char ->▐ <-
    add = { text = "▌" },
    change = { text = "▌" },
    delete = { text = "▌" },
    topdelete = { text = "▌" },
    changedelete = { text = "▌" },
  },

  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
    delay = 2000,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },

  -- WARN: when the file is too large `attach_to_untracked = true` causes slowness
  attach_to_untracked = true,

  sign_priority = 1, -- the lower the number the higher the priority, appear first ALWAYS
  -- TODO: test sign_priority
  yadm = {
    enable = false,
  },
  on_attach = function(bufnr)
    gitsigns_mappings(bufnr)
  end,
}
