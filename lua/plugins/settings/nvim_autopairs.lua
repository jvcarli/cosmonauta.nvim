local npairs = require "nvim-autopairs"

npairs.setup {
  -- if literal next character is a close pair and it doesn't have
  -- an open pair in same line, then it will not add a close pair
  -- BUG: (?) only works when when the next char hasn't any spaces between the first parentheses
  -- TODO: open issue about being a literal char
  enable_check_bracket_line = true, -- on by default

  map_cr = true, -- on by default

  -- treesitter integration
  check_ts = true, -- off by default
  ts_config = {
    lua = { "string" }, -- it will not add a pair on that treesitter node
    javascript = { "template_string" },
  },
}
