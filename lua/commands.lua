-- Git jump
-- Show all git changes in a quickfix list
-- taken from: SEE: https://www.reddit.com/r/vim/comments/gf2he2/what_is_the_simplest_way_to_get_all_git_changes/
--             SEE: https://gist.github.com/romainl/a3ddb1d08764b93183260f8cdf0f524f
--             SEE: related https://github.com/wincent/vcs-jump
--
-- This command uses a patched version of git-jump official script from https://github.com/git/git/tree/master/contrib/git-jump
-- The original script can't be used to populate the quickfix list from within (N)vim.
-- The edited script makes it possible to get two behaviors out of git-jump for the price of one.
-- The script can be called from the terminal using "$ git jump <options>".
-- It will open (N)vim and the quickfix list with the desired <options>
-- or you can use this script from within N(vim) too, using the `:GitJump` command defined below:
-- WARN: git-jump script MUST be a git alias otherwise the command will fail,
--       SEE: ~/.config/git/config
--       SEE: ~/.config/git/scripts/git-jump.sh
vim.cmd [[ command! -bar -nargs=* GitJump cexpr system('git jump ' . expand(<q-args>))]]

-- SyntaxHere
-- Show which syntax groups are active for the cursor position
-- from legacy/regex or TS or Both depending on what you have enabled
-- SEE: taken from https://www.reddit.com/r/neovim/comments/104sdx7/how_can_i_check_that_treesitter_is_actually_active/
vim.api.nvim_create_user_command("SyntaxHere", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local line, col = pos[1], pos[2] + 1
  print "Regex (legacy) Syntax Highlights"
  print "--------------------------------"
  print(" effective: " .. vim.fn.synIDattr(vim.fn.synID(line, col, true), "name"))
  for _, synId in ipairs(vim.fn.synstack(line, col)) do
    local synGroupId = vim.fn.synIDtrans(synId)
    print(" " .. vim.fn.synIDattr(synId, "name") .. " -> " .. vim.fn.synIDattr(synGroupId, "name"))
  end
  print " "
  print "Tree-sitter Syntax Highlights"
  print "--------------------------------"
  vim.print(vim.treesitter.get_captures_at_cursor(0))
end, {})
