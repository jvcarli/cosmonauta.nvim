--  Vista

-- How each level is indented and what to prepend.
-- This could make the display more compact or more spacious.
-- e.g., more compact: ["▸ ", ""]
-- Note: this option only works for the kind renderer, not the tree renderer.
vim.g.vista_icon_indent = { "╰─▸ ", "├─▸ " }

-- Executive used when opening vista sidebar without specifying it.
-- See all the avaliable executives via `:echo g:vista#executives`.

-- TODO: why is it not working?
-- vim.g.vista_icon_indent = {"nvim_lsp"}
-- vim.cmd("let g:vista_default_executive = 'nvim_lsp'")
