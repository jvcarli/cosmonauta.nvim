-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

local ls = require "luasnip"
-- local types = require "luasnip.util.types"

-- {{{ config

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

-- }}}

-- Snippets are separated from the engine
-- SEE: https://github.com/L3MON4D3/LuaSnip#add-snippets

-- {{{ Lua snippets source

local ls = require "luasnip"

-- This is a snippet creator (which supports lua code)
-- s(<trigger>, <nodes>)
local s = ls.s

-- This is a format node.
-- It takes a format string, and a list of nodes
-- fmt(<fmt_string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- This is an insert node
-- It takes a position (like $1) and optionally some default text
-- i(<position>, [default_text])
local i = ls.insert_node

-- Repeats a node
-- rep(<position>)
local rep = require("luasnip.extras").rep
ls.snippets = {
  lua = {
    -- Lua specific snippets go here.
    -- ls.parser.parse_snippet(<text>, <VSCode style snippet>)
    ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend"),
    ls.parser.parse_snippet("pcf", "config = function()\n  $0\nend"),
    s("req", fmt("local {} = require('{}')", { i(1, "module"), rep(1) })),
  },
}

-- }}}

-- {{{ VSCode like snippets source (not being used)

-- SEE: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#vscode-snippets-loader

-- For using VSCode-like snippets call the loader:
-- require("luasnip.loaders.from_vscode").load()
-- NOTE: You can load snippets from plugins, such as `rafamadriz/friendly-snippets`

-- }}}

--  {{{ Snipmate-like snippet source (not being used)

-- SEE: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#snipmate-snippets-loader

-- Snipmate-like scripts be added by:
-- Creating a directory inside Neovim runtimepath named `snippets` (SEE: `h: runtimepath`)
-- Inside snippets directory, create files named <filetype>.snippet and add snippets for the given filetype in it
-- for inspiration check https://github.com/honza/vim-snippets/tree/master/snippets

-- Call snippets load function:
-- require("luasnip.loaders.from_snipmate").load()

-- When using honza/vim-snippets plugin, the file with the global snippets is _.snippets,
-- so we need to tell luasnip that _ also contains global snippets:
-- ls.filetype_extend("all", { "_" })

-- }}}
