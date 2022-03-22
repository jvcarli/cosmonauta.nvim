-- Tex conceal: accents/ligatures, bold and italic, delimiters, math symbols, Greek
-- see: https://castel.dev/post/lecture-notes-1/#vim-and-latex
vim.g.tex_conceal = "abdmg" -- Neovim builtin option

vim.g.tex_flavor = "latex" -- Neovim builtin option

-- TODO: test tex conceallevel
vim.wo.conceallevel = 1
