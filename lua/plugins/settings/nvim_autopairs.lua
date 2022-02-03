local npairs = require "nvim-autopairs"

npairs.setup {
  -- if literal next character is a close pair and it doesn't have
  -- an open pair in same line, then it will not add a close pair
  -- BUG: (?) only works when when the next char hasn't any spaces between the first parentheses
  -- TODO: open issue about being a literal char
  enable_check_bracket_line = true,
}

-- MUST come AFTER setup
-- endwise rules (Note: experimental)
-- see https://github.com/windwp/nvim-autopairs/wiki/Endwise
npairs.add_rules(require "nvim-autopairs.rules.endwise-lua")
