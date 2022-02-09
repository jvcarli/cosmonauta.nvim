local ls = require "luasnip"
-- local types = require "luasnip.util.types"

ls.config.set_config {
  -- Tell LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you moved outside the selection.
  -- That means now nvim.cmp <S-Tab> (or other completions) will work
  -- TODO: improve explanation
  history = true,

  -- Updates dynamic snippets as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets
  -- TODO: check what this does
  -- enable_autosnippets = true

  -- Highlights
  -- TODO: check other ext_opts
  -- ext_opts = {}
}
