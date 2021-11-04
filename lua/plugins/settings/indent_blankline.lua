-- indent-blankline configuration
-- https://github.com/lukas-reineke/indent-blankline.nvim

require("indent_blankline").setup {
  char = "┊",
  -- char = "│",

  buftype_exclude = {
    "terminal",
    "nofile",
  },
  filetype_exclude = {
    "help",
    "packer",
    "startify",
    "man",
    "gitmessengerpopup",
  },
  show_trailing_blankline_indent = false,
}

-- TODO: convert to lua, how does v:true translate to lua?
vim.cmd "let g:indent_blankline_use_treesitter = v:true"
