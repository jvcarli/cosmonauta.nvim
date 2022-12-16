-- Tex conceal: accents/ligatures, bold and italic, delimiters, math symbols, Greek
-- SEE: https://castel.dev/post/lecture-notes-1/#vim-and-latex
vim.g.tex_conceal = "abdmg" -- Neovim builtin option

vim.g.tex_flavor = "latex" -- Neovim builtin option

-- NOTE: concealing can be confusing
vim.wo.conceallevel = 0

-- SEE: https://tex.stackexchange.com/questions/349/what-is-the-practical-difference-between-latex-and-pdflatex

vim.cmd [[setlocal spelllang=pt]] -- pt <3

-- Enable default vim spelling
-- vim.opt.spell = true -- TODO: I want to enable spelling only for tex buffers
--                               But with vim.opt it enables spelling for EVERYTHING which is really annoying
vim.cmd [[setlocal spell]]
