-- {{{ Colorcolumn
-- PEP8: https://www.python.org/dev/peps/pep-0008/#id17
-- Black Formatter: https://black.readthedocs.io/en/stable/the_black_code_style/current_style.html#line-length
-- PEP8 (<80 colorcolumn limit), Black default (<89 colorcolumn limit)

--  TODO: don't be lazy, make logic indepotent from lspconfig
-- if packer_plugins["nvim-lspconfig"] and packer_plugins["nvim-lspconfig"].loaded then
--   local lspconfig = require "lspconfig"
--   local search_ancestors = lspconfig.util.search_ancestors
--   local is_file = lspconfig.util.path.is_file
--   local path_join = lspconfig.util.path.join
--   local current_path = vim.fn.getcwd() -- TODO: this could be a problem if current_path IS NOT the project_root
--
--   vim.wo.colorcolumn = ""
--
--   local function setlocal_py_colorcolumn(startpath)
--     return search_ancestors(startpath, function(path)
--       if is_file(path_join(path, "pyproject.toml")) then
--         -- parse this file and if it has black formatter as a dependency
--         -- use: vim.wo.colorcolumn = "89"
--         vim.wo.colorcolumn = "89"
--       else
--         vim.wo.colorcolumn = "80"
--         -- BUG: this else conditional doesn't work
--       end
--     end)
--   end
--
--   setlocal_py_colorcolumn(current_path)
-- end

-- }}}

-- Folding
vim.opt.foldlevel = 99
