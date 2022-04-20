-- Taken from: https://thoughtbot.com/blog/wrap-existing-text-at-80-characters-in-vim
-- Automatically wrap at 80 characters
-- https://prettier.io/docs/en/options.html

-- Follows Prettier Markdown default line wrapping:
-- Lines can be select in visual mode and formatted using `gq` "
-- SEE: h: gq

vim.opt.textwidth = 80

-- Follows prettier default tab/space behavior
vim.opt.tabstop = 2 -- show <tab> character as 2 spaces
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.wo.conceallevel = 2
