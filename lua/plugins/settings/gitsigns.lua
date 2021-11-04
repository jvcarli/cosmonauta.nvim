require("gitsigns").setup {
  signs = {

    -- Left Half Block Char -> ▌ <- (U+258C)
    -- see: https://www.compart.com/en/unicode/U+258C

    -- Left Five Eighths Block char -> ▋ <- (U+258B)
    -- see: https://www.compart.com/en/unicode/U+258B

    -- Right Half Block char ->▐ <-
    -- see: https://www.compart.com/en/unicode/U+2590

    -- left one quarter block char --> ▎<- (U+258E)
    -- see: https://www.compart.com/en/unicode/U+258E

    -- left three quarters block -->▊-< (U+258A)

    add = { hl = "GitSignsAdd", text = "▊", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▊", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "▊", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "▊", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▊", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },

  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
    delay = 2000,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },

  -- sign_priority = 1, -- the lower the number the higher the priority
  yadm = {
    enable = false,
  },
}
