-- PEP8: https://www.python.org/dev/peps/pep-0008/#id17
-- Black Formatter: https://black.readthedocs.io/en/stable/the_black_code_style/current_style.html#line-length
-- PEP8 (<80 colorcolumn limit), Black default (<89 colorcolumn limit)

-- buffer option
vim.cmd "setlocal colorcolumn=80,89"

-- BUG: vim.bo doesn't work for buffer option as it should
-- BUG: vim.opt_local doesn't work either
-- setlocal works fine

-- TODO: report bug to upstream Neovim
-- vim.bo.colorcolumn = "80,89"
-- vim.opt.colorcolumn = "80,89"
