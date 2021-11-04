local wk = require("which-key")

wk.setup {
    -- configuration comes here
    -- or leave it empty to use the default settings
}

-- wk.register({
--   f = {
--     name = "file", -- optional group name
--     f = { "<cmd>Telescope find_files<cr>", "Fifafand File" }, -- create a binding with label
--                     },
--   }, { prefix = "<leader>" },
--     {
--   mode = "n", -- NORMAL mode
--   -- prefix: use "<leader>f" for example for mapping everything related to finding files
--   -- the prefix is prepended to every mapping part of `mappings`
--   prefix = "",
--   buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = false, -- use `nowait` when creating keymaps
-- })

-- TODO: setup keymaps

-- Disbale default mappings, see: https://github.com/arthurxavierx/vim-caser#global-options
vim.g.caser_no_mappings = 1

wk.register({
  -- telescope
  ["<leader>f"] = { name = "+file" },
  -- ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
  -- ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },

  -- vim-caser
  ["gs"]  = { name = "+Word casing" },
  ["gsk"] = { "<Plug>CaserKebabCase", "kebab-case" },
  ["gsK"]  = { "<Plug>CaserTitleKebabCase", "Kebab-Case" },
  ["gs."] = { "<Plug>CaserDotCase", "dot.case" },
  ["gs_"] = { "<Plug>CaserSnakeCase", "snake_case" },
  ["gsp"]  = { "<Plug>CaserMixedCase", "PascalCase" },
  ["gs<space>"]  = { "<Plug>CaserSpaceCase", "space case" },
  ["gsc"]  = { "<Plug>CaserCamelCase", "camelCase" },
  ["gsU"]  = { "<Plug>CaserUpperCase", "UPPER_CASE" },
  ["gst"]  = { "<Plug>CaserTitleCase", "Title Case" },
  ["gss"]  = { "<Plug>CaserSentenceCase", "Sentence case" },

})
