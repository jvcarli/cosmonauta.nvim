-- Auto fold diffs in commit
-- Reasoning, SEE: https://github.com/tpope/vim-fugitive/issues/146#issuecomment-3733461

-- REALLY slow on insert mode even with FastFold plugin
-- so I'm using tree-sitter highlights and waiting for folding for gitcommit files
-- vim.wo.foldmethod = "syntax"

vim.wo.spell = true
