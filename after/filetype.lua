--=======================================--
--                Formatting             --
--=======================================--

-- taken from tjdevries config:
-- SEE: https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/plugin/options.lua#L65-L74
--
-- Helpful related items:
--   1. :center, :left, :right
--   2. gw{motion} - Put cursor back after formatting motion.
--
-- TODO: w, {v, b, l}
-- SEE: `:h fo-table`
-- + b -- TODO: test fo-b
-- - "2" -- TODO: test fo-2

-- string order MATTER if you are just removing some options using - operator

-- SEE: https://www.reddit.com/r/neovim/comments/pgtdi1/trouble_with_setting_formatoptions_in_lua/
-- SEE: https://vi.stackexchange.com/questions/9366/set-formatoptions-in-vimrc-is-being-ignored
-- SEE: https://github.com/vim/vim/issues/4680
-- SEE: https://www.reddit.com/r/vim/comments/34hw63/is_there_a_way_to_force_formatoptionso_everywhere/

-- Don't use autogroups inside ftdetect files
vim.cmd "autocmd FileType * set formatoptions=cjnqr"

--   - "a" -- Auto formatting is BAD.
--   - "t" -- Don't auto-wrap text using textwidth. I got linters for that.
--   + "c" -- In general, I like it when comments respect textwidth
--   + "q" -- Allow formatting comments w/ gq
--   - "o" -- O and o, don't continue comments when starting a new line with o or O
--   + "r" -- But do continue when pressing enter.
--   + "n" -- Indent past the formatlistpat, not underneath it.
--   + "j" -- Auto-remove comments if possible.
