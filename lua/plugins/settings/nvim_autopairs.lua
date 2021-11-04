local remap = vim.api.nvim_set_keymap
local npairs = require "nvim-autopairs"

if packer_plugins["coq_nvim"] and packer_plugins["coq_nvim"].loaded then
  npairs.setup { map_bs = false }

  -- these mappings are coq recommended mappings unrelated to nvim-autopairs
  remap("i", "<esc>", [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
  remap("i", "<c-c>", [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
  remap("i", "<tab>", [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
  remap("i", "<s-tab>", [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

  -- skip it, if you use another global object
  _G.MUtils = {}

  MUtils.CR = function()
    if vim.fn.pumvisible() ~= 0 then
      if vim.fn.complete_info({ "selected" }).selected ~= -1 then
        return npairs.esc "<c-y>"
      else
        return npairs.esc "<c-e>" .. npairs.autopairs_cr()
      end
    else
      return npairs.autopairs_cr()
    end
  end
  remap("i", "<cr>", "v:lua.MUtils.CR()", { expr = true, noremap = true })

  MUtils.BS = function()
    if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
      return npairs.esc "<c-e>" .. npairs.autopairs_bs()
    else
      return npairs.autopairs_bs()
    end
  end
  remap("i", "<bs>", "v:lua.MUtils.BS()", { expr = true, noremap = true })
end

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
