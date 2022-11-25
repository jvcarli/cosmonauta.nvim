--=======================================--
--                Formatting             --
--=======================================--

-- TODO: see https://blog.siddharthkannan.in/vim/configuration/2019/11/02/format-list-pat-and-vim/

-- taken from tjdevries config:
-- SEE: https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/plugin/options.lua#L77-L91
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

--   - "a" -- Auto formatting is BAD. REALLY BAD
--   - "t" -- Don't auto-wrap text (text is NOT comments) using textwidth. I got linters for that.

--   + "c" -- Auto-wrap comments using 'textwidth'. Not all linters will format commets (i.e.: Stylua).
--                                                  TODO: set a reasonable textwidth for your most used languages

--   + "q" -- Allow formatting comments w/ gq. TODO: what does this one does?

--   - "o" -- O and o, don't continue comments when starting a new line with o or O. (Annoying)
--   + "r" -- But do continue when pressing enter. (Expected Behavior)

--   + "n" -- Indent past the formatlistpat, not underneath it, respecting textwidth. Example:
--
--   1. the first item          (instead of:)         1. the first item
--      wraps                                         wraps
--   2. the second item                               2. the second item

--   + "j" -- Where it makes sense, remove a comment leader when joining lines.
