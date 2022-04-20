-- SEE: https://youtu.be/n4Lp4cV8YR0?t=2085

-- There's short hand built into :lua command .
-- SEE: https://www.reddit.com/r/neovim/comments/tftryc/plugin_authors_i_created_a_lua_script_that_turns/
-- TODO: use them
-- :lua =vim.api

-- Good for plugin development
P = function(v)
  print(vim.pretty_print(v))
end
